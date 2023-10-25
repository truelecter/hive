{config, ...}: {
  services.grafana = {
    enable = true;

    settings = {
      server = {
        http_addr = "0.0.0.0";
        http_port = 3000;
      };

      users.viewers_can_edit = true;

      auth = {
        disable_login_form = true;
      };

      "auth.anonymous" = {
        enabled = true;
        org_role = "Editor";
      };
    };

    provision = {
      enable = true;
      datasources.settings.datasources = [
        {
          name = "Prometheus";
          type = "prometheus";
          access = "proxy";
          url = "http://127.0.0.1:${toString config.services.prometheus.port}";
        }
      ];
    };
  };

  services.telegraf = {
    enable = true;
    extraConfig = {
      inputs.openweathermap = {
        app_id = "$OWM_API_KEY";
        city_id = ["688723" "703448"];
        lang = "ua";
        fetch = ["weather" "forecast"];
        units = "metric";
        interval = "10m";
      };

      outputs.prometheus_client = {
        listen = ":9273";
        expiration_interval = "120s";
      };
    };
    environmentFiles = [
      config.sops.templates."telegraf.env".path
    ];
  };

  services.prometheus = {
    port = 3020;
    enable = true;

    scrapeConfigs = [
      {
        job_name = "telegraf";
        scrape_interval = "60s";
        metrics_path = "/metrics";
        static_configs = [
          {
            targets = [
              "localhost:9273"
            ];
          }
        ];
      }
    ];
  };

  services.influxdb2 = {
    enable = true;
    provision = {
      enable = true;

      initialSetup = {
        bucket = "weather";
        username = "weather";
        tokenFile = config.sops.secrets.wk-influx-admin-token.path;
        retention = 7 * 24 * 60 * 60;
        passwordFile = config.sops.secrets.wk-influx-admin-pw.path;
        organization = "weather";
      };
    };
  };

  sops.secrets.wk-influx-admin-token.owner = "influxdb2";
  sops.secrets.wk-influx-admin-pw.owner = "influxdb2";

  sops.templates."telegraf.env" = {
    content = ''
      OWM_API_KEY = "${config.sops.placeholder.wk-openweathermap-api}"
    '';
  };
}
