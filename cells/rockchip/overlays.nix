{
  inputs,
  cell,
}: let
  inherit (inputs) nixos-rockchip;

  latest = import inputs.latest {
    inherit (inputs.nixpkgs) system;
    config.allowUnfree = true;
  };

  master = import inputs.nixpkgs-master {
    inherit (inputs.nixpkgs) system;
    config.allowUnfree = true;
  };
in {
  packages = _: _: cell.packages;
  # dtmerge = final: prev: {
  #   deviceTree =
  #     prev.deviceTree
  #     // {
  #       applyOverlays = latest.deviceTree.applyOverlays;
  #     };
  # };

  rock-pi-4-kernel = _: _: {
    linuxPackages_rockPi4 = nixos-rockchip.legacyPackages.kernel_linux_6_12_rockchip;
    uBoot_rockPi4 = nixos-rockchip.packages.uBootRadxaRock4;
  };

  btt-pi-v2-kernel = final: prev: rec {
    inherit (cell.packages) btt-6_12-dtb uboot-btt;

    linuxPackages_bttPi2_6_12 = nixos-rockchip.legacyPackages.kernel_linux_6_12_rockchip;

    deviceTree =
      prev.deviceTree
      // {
        applyOverlays = final.callPackage ./extra/dtmerge.nix {};
      };
  };
}
