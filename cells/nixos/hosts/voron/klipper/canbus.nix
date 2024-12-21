{...}: {
  # services.udev.extraRules = ''
  #   SUBSYSTEM=="net", ACTION=="add|change", KERNEL=="can0", ATTR{tx_queue_len}="1024"
  # '';

  systemd.network = {
    networks."80-can0" = {
      enable = true;
      matchConfig = {
        Name = "can0";
      };
      linkConfig = {
        RequiredForOnline = "no";
      };
      canConfig = {
        BitRate = "1M";
      };
    };

    links."80-can0" = {
      enable = true;
      matchConfig = {
        OriginalName = "can0";
      };
      linkConfig = {
        TransmitQueueLength = 256;
      };
    };
  };
}
