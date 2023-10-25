{pkgs, ...}: {
  systemd.services."cage-tty1".serviceConfig.Restart = "always";

  services.cage = {
    enable = true;
    extraArguments = ["-d"];
    program = "${pkgs.firefox}/bin/firefox -kiosk -private-window http://127.0.0.1:3000/";
    user = "truelecter";
  };
}
