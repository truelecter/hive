# ip link set can0 type can bitrate 500000
# ip link set can0 txqueuelen 256
{...}: {
  services.udev.extraRules = ''
    SUBSYSTEM=="net", ACTION=="add|change", KERNEL=="can*", ATTR{tx_queue_len}="1000"
  '';

  services.resolved.enable = false;

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
          BitRate=500000
        '';
      };
    };
  };
}
