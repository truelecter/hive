{
  inputs,
  cell,
}: let
  latest = import inputs.latest {
    inherit (inputs.nixpkgs) system;
    config.allowUnfree = true;
  };

  rpi-4-kernel = import inputs.rpi-4-kernel {
    inherit (inputs.nixpkgs) system;
    config.allowUnfree = true;
  };
in {
  packages = _: _: cell.packages;
  kernel = _: _: {
    inherit (rpi-4-kernel) raspberrypiWirelessFirmware raspberrypifw linuxPackages_rpi4;
  };
}
