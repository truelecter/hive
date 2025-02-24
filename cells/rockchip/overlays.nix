{
  inputs,
  cell,
}: let
  inherit (inputs) nixos-rockchip;
in {
  packages = _: _: cell.packages;
  dtmerge = final: prev: {
    deviceTree =
      prev.deviceTree
      // {
        applyOverlays = final.callPackage ./extra/dtmerge.nix {};
      };
    makeModulesClosure = x: prev.makeModulesClosure (x // {allowMissing = true;});
  };

  rock-pi-4-kernel = _: _: {
    linuxPackages_rockPi4 = nixos-rockchip.legacyPackages.kernel_linux_6_12_rockchip;
    uBoot_rockPi4 = nixos-rockchip.packages.uBootRadxaRock4;
  };

  btt-pi-v2-kernel = _: _: rec {
    linuxPackages_bttPi2 = nixos-rockchip.legacyPackages.kernel_linux_6_12_rockchip;
    uBoot_bttPi2 = cell.packages.ubootBttCb2;
    bttCb2Dtb = cell.packages.bttCb2Dtb.override {linuxPackages = linuxPackages_bttPi2;};
  };
}
