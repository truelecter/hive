{
  imports = [
    ./dawncraft.nix
    ./e6e.nix
    ./e9e.nix
    ./sevtech.nix
    ./vanilla.nix
    ./litv3.nix
  ];

  users = {
    groups = {
      minecraft-servers = {};
      minecraft-servers-backup = {};
    };
    users.truelecter.extraGroups = ["minecraft-servers"];
  };

  services.minecraft-servers = let
    bluemapConfig = port: ''
      enabled: true
      port: ${toString port}
      ip: "127.0.0.1"
      ##
    '';
  in {
    eula = true;
    users.extraGroups = ["minecraft-servers-backup"];

    instances.dawncraft.serverProperties = {
      server-port = 25566;
      rcon-port = 25596;
    };

    instances.e6e.serverProperties = {
      server-port = 25567;
      rcon-port = 25597;
    };

    instances.e9e = {
      customization.create."config/bluemap/webserver.conf".text = bluemapConfig 8108;
      serverProperties = {
        server-port = 25568;
        rcon-port = 25598;
      };
    };

    instances.litv3 = {
      customization.create."config/bluemap/webserver.conf".text = bluemapConfig 8109;
      serverProperties = {
        server-port = 25569;
        rcon-port = 25599;
      };
    };

    instances.sevtech.serverProperties = {
      server-port = 25565;
      rcon-port = 25595;
    };
  };

  services.minecraft-server.serverProperties.server-port = 25580;

  security.acme = {
    acceptTerms = true;
    email = "andrew.panassiouk@gmail.com";
  };

  services.nginx = {
    enable = true;
    virtualHosts = let
      bluemap = port: {
        enableACME = true;
        forceSSL = true;
        locations."/".proxyPass = "http://127.0.0.1:${toString port}";
      };
    in {
      "litv3.tenma.moe" = bluemap 8109;
    };
  };

  systemd.extraConfig = ''
    DefaultLimitNOFILE = 102400
    DefaultLimitNOFILESoft = 102400
  '';

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
