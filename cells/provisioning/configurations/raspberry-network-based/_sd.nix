{
  lib,
  modulesPath,
  ...
}: {
  imports = [
    "${toString modulesPath}/installer/sd-card/sd-image-aarch64.nix"
  ];

  sdImage = {
    firmwareSize = 100;
    compressImage = false;
  };
}
