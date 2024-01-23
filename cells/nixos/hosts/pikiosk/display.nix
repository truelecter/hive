{pkgs, ...}: {
  hardware.deviceTree = {
    overlays = let
      overlay = name: {
        name = name;
        dtboFile = "${pkgs.device-tree_rpi.overlays}/${name}.dtbo";
      };
    in [
      (overlay "disable-bt")
    ];
  };
}
