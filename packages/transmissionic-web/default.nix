{
  pkgs,
  stdenvNoCC,
  lib,
  sources,
  ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "transmissionic-web";

  inherit (sources.transmissionic) version src;

  dontConfigure = true;
  dontBuild = false;

  nativeBuildInputs = [pkgs.nodejs-16_x];

  buildPhase = ''
    # Fix for Error: EACCES: permission denied, mkdir '/homeless-shelter'
    export HOME=$(pwd)/home; mkdir -p $HOME
    npm ci
    npm run build:webui
  '';

  installPhase = ''
    mkdir -p $out
    cp -r dist/* $out
  '';

  meta = with lib; {
    description = "Transmissionic, but only WebUI";
    homepage = "https://github.com/6c65726f79/Transmissionic";
    license = licenses.mit;
    platforms = pkgs.nodejs-16_x.meta.platforms;
  };
}
