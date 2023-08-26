{pkgs, ...}: {
  services.minecraft-servers = {
    eula = true;
    instances = {
      e6e = {
        enable = true;
        serverProperties = {
          server-port = 25590;
        };
        serverPackage = pkgs.mcs-enigmatica-6-expert;
        backup.restic = {
          enable = true;
          repository = "minecraft";
        };
      };
    };
  };
}
