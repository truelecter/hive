let
  wifiInterface = "wifi-ext";
  ethernetInterface = "eth";
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

      "10-eth" = {
        linkConfig = {
          Name = ethernetInterface;
        };

        matchConfig = {
          PermanentMACAddress = "dc:a6:32:48:e9:7b";
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

      "40-eth" = {
        matchConfig.Name = ethernetInterface;
        address = [
          "10.3.0.128/27"
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
      "net.ipv4.conf.${ethernetInterface}.rp_filter" = false;
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

      dhcp-range = ["${ethernetInterface},10.3.0.129,10.3.0.158,24h"];
      dhcp-option = [
        # "option:router,10.3.0.1"
        "option:dns-server,10.3.0.1"
      ];

      interface = ethernetInterface;
    };
  };
}
