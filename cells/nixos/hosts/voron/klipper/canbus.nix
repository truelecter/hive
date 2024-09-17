{...}: {
  services.udev.extraRules = ''
    SUBSYSTEM=="net", ACTION=="add|change", KERNEL=="can*", ATTR{tx_queue_len}="1024"
  '';

  services.resolved.enable = false;

  networking.interfaces.can0.useDHCP = false;
  networking.dhcpcd.denyInterfaces = ["can*"];

  systemd.network = {
    enable = true;
    wait-online.timeout = 0;
    networks = {
      canbus = {
        enable = true;
        matchConfig = {
          Name = "can*";
        };
        extraConfig = ''
          [CAN]
          BitRate=1000000
        '';
      };
    };
  };
}
