{
  inputs,
  cell,
}: {
  wsl-nvidia-docker = final: prev: {
    mkNvidiaContainerPkg = {
      name,
      containerRuntimePath,
      configTemplate,
      additionalPaths ? [],
    }: let
      nvidia-container-toolkit = prev.callPackage "${inputs.nixos}/pkgs/applications/virtualization/nvidia-container-toolkit" {
        inherit containerRuntimePath configTemplate libnvidia-container;
      };

      libnvidia-container = (prev.callPackage "${inputs.nixos}/pkgs/applications/virtualization/libnvidia-container" {}).overrideAttrs (_: {
        postInstall = let
          inherit (prev.addOpenGLRunpath) driverLink;
          libraryPath = prev.lib.makeLibraryPath ["$out" driverLink "${driverLink}-32" "/usr/lib/wsl"];
        in ''
          remove-references-to -t "${prev.go}" $out/lib/libnvidia-container-go.so.${libnvidia-container.version}
          wrapProgram $out/bin/nvidia-container-cli --prefix LD_LIBRARY_PATH : ${libraryPath}
        '';
      });
    in
      prev.symlinkJoin {
        inherit name;
        paths =
          [
            libnvidia-container
            nvidia-container-toolkit
          ]
          ++ additionalPaths;
      };
  };
}
