{
  config,
  pkgs,
  lib,
  ...
}: let
  klipperCfg = config.services.klipper;
  moonrakerCfg = config.services.moonraker;
in {
  services.moonraker = {
    enable = true;
    address = "0.0.0.0";
    allowSystemControl = true;

    inherit (klipperCfg) user group;

    settings = {
      "include /etc/moonraker.d/*.cfg" = {};
    };
  };

  environment.etc = builtins.listToAttrs (
    builtins.map (
      path: {
        name = "moonraker.d/${builtins.baseNameOf path}";
        value = {
          inherit (klipperCfg) user group;

          source = path;
        };
      }
    )
    (lib.filesystem.listFilesRecursive ./configs/moonraker.d)
  );

  systemd.services.moonraker = {
    script = lib.mkForce ''
      cp /etc/moonraker.cfg ${moonrakerCfg.configDir}/moonraker-temp.cfg
      chmod u+w ${moonrakerCfg.configDir}/moonraker-temp.cfg
      exec ${pkgs.moonraker}/bin/moonraker -c ${moonrakerCfg.configDir}/moonraker-temp.cfg -d ${moonrakerCfg.stateDir}/
    '';

    serviceConfig = {
      SupplementaryGroups = config.users.users.klipper.extraGroups;
      Environment = "PYTHONPATH=${pkgs.python39Packages.libgpiod}";
      BindReadOnlyPaths = "${pkgs.python39Packages.libgpiod}/lib/python3.9:/usr/lib/python3.9:norbind";
    };
  };
}
