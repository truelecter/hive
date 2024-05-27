{
  lib,
  buildNpmPackage,
  sources,
  cypress,
  zip,
  # TODO: extract it to common lib
  prefetch-npm-deps,
  writeShellScriptBin,
  ...
}: let
  mkNpmDepsHashCalculator = src:
    writeShellScriptBin "npm-deps-hash" ''
      echo "\"$(${prefetch-npm-deps}/bin/prefetch-npm-deps ${src}/package-lock.json)\""
    '';
in
  buildNpmPackage {
    pname = "mainsail";

    inherit (sources.mainsail) version src;

    npmDepsHash = import ./_deps-hash/mainsail-npm.nix;

    nativeBuildInputs = [
      cypress
      zip
    ];

    dontNpmBuild = true;

    buildPhase = ''
      runHook preBuild

      npx vite build

      runHook postBuild
    '';

    prePatch = ''
      export CYPRESS_INSTALL_BINARY=0
      export CYPRESS_RUN_BINARY=${cypress}/bin/Cypress
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share
      cp -r dist $out/share/mainsail

      runHook postInstall
    '';

    passthru.npmDepsHash = mkNpmDepsHashCalculator sources.mainsail.src;

    meta = with lib; {
      description = "Klipper web interface";
      homepage = "https://docs.mainsail.xyz";
      license = licenses.gpl3Only;
    };
  }
