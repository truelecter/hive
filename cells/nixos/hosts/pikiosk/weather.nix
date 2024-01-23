{
  config,
  pkgs,
  ...
}: {
  services.grafana = {
    enable = true;

    declarativePlugins = with pkgs.grafanaPlugins; [
      grafana-clock-panel
    ];

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
        org_role = "Admin";
      };

      panels = {
        disable_sanitize_html = true;
      };
    };

    provision = {
      enable = true;

      datasources.settings.datasources = [
        {
          name = "Influx";
          uid = "influx";
          type = "influxdb";
          access = "proxy";
          url = "http://127.0.0.1:8086";
          jsonData = {
            defaultBucket = "weather";
            organization = "weather";

            httpMode = "POST";
            version = "Flux";
          };
          secureJsonData = {
            token = "$__file{${config.sops.templates.grafana-influx-token.path}}";
          };
        }
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

      outputs.influxdb_v2 = {
        urls = ["http://127.0.0.1:8086"];
        organization = "weather";
        bucket = "weather";
        token = "$INFLUX_TOKEN";
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
        organization = "weather";

        retention = 7 * 24 * 60 * 60;

        tokenFile = config.sops.secrets.wk-influx-admin-token.path;
        passwordFile = config.sops.secrets.wk-influx-admin-pw.path;
      };
    };
  };

  # TODO: share these I guess
  sops.secrets.wk-influx-admin-token.owner = "influxdb2";
  sops.secrets.wk-influx-admin-pw.owner = "influxdb2";

  sops.templates."telegraf.env" = {
    owner = "telegraf";
    content = ''
      OWM_API_KEY = "${config.sops.placeholder.wk-openweathermap-api}"
      INFLUX_TOKEN = "${config.sops.placeholder.wk-influx-admin-token}"
    '';
  };

  sops.templates.grafana-influx-token = {
    owner = "grafana";
    content = config.sops.placeholder.wk-influx-admin-token;
  };
}
