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

  npmDepsHash = "sha256-gIwon+sH2f3+lPgeP0D1Sjp5XV9F3Tyd28bijhQh42c=";

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
