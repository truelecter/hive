{pkgs, ...}: {
  systemd.services."cage-tty1".serviceConfig.Restart = "always";

  services.cage = {
    enable = true;
    extraArguments = ["-d"];
    program = "${pkgs.meteo}/bin/com.gitlab.bitseater.meteo";
    user = "truelecter";
  };
}
