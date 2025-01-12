{
  stdenv,
  lib,
  kernel,
}: let
  modPath = "drivers/net/wireless/intel/iwlwifi";
  modDestDir = "$out/lib/modules/${kernel.modDirVersion}/kernel/${modPath}";
in
  stdenv.mkDerivation rec {
    name = "intel-${kernel.version}";

    inherit (kernel) src version;

    postPatch = ''
      cd ${modPath}
      sed -i 's|$(srctree)/||' {d,m}vm/Makefile
    '';

    nativeBuildInputs = kernel.moduleBuildDependencies;

    makeFlags =
      kernel.makeFlags
      ++ [
        "-C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
        "M=$(PWD)"
        "modules"
      ];

    enableParallelBuilding = true;

    installPhase = ''
      runHook preInstall

      mkdir -p ${modDestDir}
      find . -name '*.ko' -exec cp --parents '{}' ${modDestDir} \;
      find ${modDestDir} -name '*.ko' -exec xz -f '{}' \;

      runHook postInstall
    '';

    meta = with lib; {
      description = "iwlwifi kernel module";
      inherit (kernel.meta) license platforms;
    };
  }
