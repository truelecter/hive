{
  pkgs,
  stdenvNoCC,
  lib,
  sources,
  inputs,
  ...
}: let
  buildNpmPackage = (pkgs.callPackage inputs.nix-npm-buildpackage {}).buildNpmPackage;
in
  buildNpmPackage {
    pname = "transmissionic-web";

    inherit (sources.transmissionic) version src;

    npmBuild = "npm run build:webui";
    postInstall = "cp -r dist/* $out";

    meta = with lib; {
      description = "Transmissionic, but only WebUI";
      homepage = "https://github.com/6c65726f79/Transmissionic";
      license = licenses.mit;
      platforms = pkgs.nodejs-12_x.meta.platforms;
    };
  }
