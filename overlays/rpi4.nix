final: prev: {
  linuxPackages_rpi4 = prev.linuxPackages_rpi4.extend (prev.lib.const (ksuper: {
    inherit (prev.sources.rpi-linux) version src;
  }));

  raspberrypiWirelessFirmware = prev.raspberrypiWirelessFirmware.overrideAttrs (o: rec {
    src = [
      prev.sources.rpi-fw-nonfree.src
      prev.sources.rpi-fw-bluez.src
    ];
  });

  raspberrypifw = prev.raspberrypifw.overrideAttrs (o: rec {
    inherit (prev.sources.rpi-fw) version src;
  });
}
