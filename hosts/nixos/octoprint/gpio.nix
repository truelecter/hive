{
  pkgs,
  self,
  lib,
  ...
}: let
  build-overlay = overlay:
    pkgs.runCommandCC overlay {nativeBuildInputs = [pkgs.dtc];} ''
      mkdir $out
      cd $out
      builddtb() {
        $CC -x assembler-with-cpp -E $1 -o temp
        # egrep -v '^#' < temp > temp2
        dtc temp -o $2
        rm temp
        # temp2
      }
      builddtb ${self}/hosts/nixos/octoprint/overlays/${overlay}.dts ${overlay}.dtb
    '';
  ov5647 = build-overlay "ov5647";
  disable-bt = build-overlay "disable-bt";
  uart0 = build-overlay "uart0";
  rpi-ft5406 = build-overlay "rpi-ft5406";
  spi4 = build-overlay "spi4";
  spi6 = build-overlay "spi6";
in {
  environment.systemPackages = [ pkgs.gpio-utils ];

  users.groups.gpio = {};
  users.groups.spi = {};

  hardware.raspberry-pi."4" = {
    i2c0.enable = true;
    i2c1.enable = false;
    # apply-overlays-dtmerge.enable = true;
  };

  hardware.deviceTree = {
    enable = true;
    filter = lib.mkForce "bcm2711-rpi-4-b.dtb";
    overlays = [
      "${ov5647}/ov5647.dtb"
      "${disable-bt}/disable-bt.dtb"
      "${uart0}/uart0.dtb"
      "${rpi-ft5406}/rpi-ft5406.dtb"
      "${spi4}/spi4.dtb"
      "${spi6}/spi6.dtb"
    ];
  };

  nixpkgs.overlays = [
    # patch to not mess with dts
    (final: prev: {
      deviceTree.applyOverlays = prev.callPackage ./apply-overlays-dtmerge.nix {};
    })
    (final: prev: {
      ffmpeg = prev.ffmpeg_5;
    })
  ];

  services.udev.extraRules = ''
    SUBSYSTEM=="bcm2835-gpiomem", KERNEL=="gpiomem", GROUP="gpio",MODE="0660"
    SUBSYSTEM=="gpio", GROUP="gpio", MODE="0660"
    SUBSYSTEM=="gpio", KERNEL=="gpiochip*", ACTION=="add", RUN+="${pkgs.bash}/bin/bash -c 'chown root:gpio  /sys/class/gpio/export /sys/class/gpio/unexport ; chmod 220 /sys/class/gpio/export /sys/class/gpio/unexport'"
    SUBSYSTEM=="gpio", KERNEL=="gpio*", ACTION=="add",RUN+="${pkgs.bash}/bin/bash -c 'chown root:gpio /sys%p/active_low /sys%p/direction /sys%p/edge /sys%p/value ; chmod 660 /sys%p/active_low /sys%p/direction /sys%p/edge /sys%p/value'"
    SUBSYSTEM=="spidev", GROUP="spi", MODE="0660"
    KERNEL=="vchiq",GROUP="video",MODE="0660"
  '';
}
