{
  lib,
  buildNpmPackage,
  sources,
  cypress,
  zip,
  ...
}:
buildNpmPackage {
  pname = "mainsail";

  inherit (sources.mainsail) version src;

  # TODO: automate this thing with updateScript
  npmDepsHash = "sha256-g2inNV1+AzOlEUiPq5PVGB/CK2MItn+1OeaZV8QhRI0=";

  # convert to native
  nativeBuildInputs = [
    cypress
    zip
  ];

  prePatch = ''
    export CYPRESS_INSTALL_BINARY=0
    export CYPRESS_RUN_BINARY=${cypress}/bin/Cypress
  '';

  installPhase = ''
    mkdir -p $out/share
    rm dist/mainsail.zip
    cp -r dist $out/share/mainsail
  '';

  meta = with lib; {
    description = "Klipper web interface";
    homepage = "https://docs.mainsail.xyz";
    license = licenses.gpl3Only;
  };
}
