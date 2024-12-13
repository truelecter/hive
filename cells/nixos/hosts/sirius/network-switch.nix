{config, ...}: let
  wifiInterface = "wifi-ext";
  wifiAPInterface = "wifi-ap";
  leftEthernetInterface = "eth-l";
  rightEthernetInterface = "eth-r";
in {
  networking.useDHCP = false;

  systemd.network = {
    enable = true;

    links = {
      "10-wifi-ext" = {
        linkConfig = {
          Name = wifiInterface;
        };

        matchConfig = {
          PermanentMACAddress = "c8:3a:35:ac:03:f0";
        };
      };

      "10-wifi-ap" = {
        linkConfig = {
          Name = wifiAPInterface;
        };

        matchConfig = {
          PermanentMACAddress = "a8:6e:84:da:99:37";
        };
      };

      "10-eth-l" = {
        linkConfig = {
          Name = leftEthernetInterface;
        };

        matchConfig = {
          PermanentMACAddress = "00:e0:4c:17:57:56";
        };
      };

      "10-eth-r" = {
        linkConfig = {
          Name = rightEthernetInterface;
        };

        matchConfig = {
          PermanentMACAddress = "00:e0:4c:17:57:54";
        };
      };
    };

    networks = {
      "40-wifi" = {
        matchConfig.Name = wifiInterface;

        networkConfig = {
          DHCP = "ipv4";
          DNSOverTLS = false;
          DNSSEC = false;
        };

        networkConfig.LinkLocalAddressing = "no";
        # make routing on this interface a dependency for network-online.target
        linkConfig.RequiredForOnline = "routable";
      };

      "40-wifi-ap" = {
        matchConfig.Name = wifiAPInterface;
        address = [
          "10.3.0.161/27"
        ];
        networkConfig = {
          ConfigureWithoutCarrier = true;
        };
      };

      "40-eth-r" = {
        matchConfig.Name = rightEthernetInterface;
        address = [
          "10.3.0.129/27"
        ];
        networkConfig = {
          ConfigureWithoutCarrier = true;
        };
      };
    };
  };

  boot.kernel = {
    sysctl = {
      "net.ipv4.conf.all.forwarding" = true;
      "net.ipv4.conf.all.proxy_arp" = true;
      "net.ipv4.conf.all.rp_filter" = false;
      "net.ipv4.conf.${wifiInterface}.rp_filter" = false;
      "net.ipv4.conf.${wifiAPInterface}.rp_filter" = false;
      "net.ipv4.conf.${rightEthernetInterface}.rp_filter" = false;
    };
  };

  services.dnsmasq = {
    enable = true;
    settings = {
      port = 0;

      # sensible behaviours
      domain-needed = true;
      bogus-priv = true;
      no-resolv = true;

      dhcp-range = [
        "${wifiAPInterface},10.3.0.161,10.3.0.190,24h"
        "${rightEthernetInterface},10.3.0.130,10.3.0.158,24h"
      ];
      dhcp-option = [
        # "option:router,10.3.0.1"
        "option:dns-server,10.3.0.1"
      ];

      dhcp-host = let
        voronMac = "e4:5f:01:67:cc:6f";
        voronIp = "10.3.0.150";

        bblMac = "64:e8:33:77:71:b0";
        bblIp = "10.3.0.162";
      in [
        "${voronMac},${voronIp}"
        "${bblMac},${bblIp}"
      ];
    };
  };

  services.hostapd = {
    enable = true;
    radios = {
      # 2.4GHz
      ${wifiAPInterface} = {
        band = "2g";
        noScan = true;
        channel = 6;
        countryCode = "US";
        wifi4 = {
          capabilities = ["HT20/HT40"];
        };
        networks = {
          ${wifiAPInterface} = {
            ssid = "Xata290.2";
            authentication = {
              wpaPasswordFile = config.sops.secrets.xata-password.path;
              mode = "wpa2-sha256";
            };
          };
        };
      };
    };
  };

  systemd.network.wait-online.enable = false;
}
