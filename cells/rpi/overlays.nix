{
  inputs,
  cell,
}: let
  latest = import inputs.latest {
    inherit (inputs.nixpkgs) system;
    config.allowUnfree = true;
  };
in {
  packages = _: _: cell.packages;
  kernel = _: _: {
    inherit (latest) raspberrypiWirelessFirmware raspberrypifw linuxPackages_rpi4;
  };
  dtmerge = final: prev: {
    deviceTree =
      prev.deviceTree
      // {
        applyOverlays = final.callPackage ./extra/dtmerge.nix {};
      };
    makeModulesClosure = x: prev.makeModulesClosure (x // {allowMissing = true;});
  };
}
