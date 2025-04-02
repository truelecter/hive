{
  stdenvNoCC,
  lib,
  sources,
  unzip,
  ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "transmissionic-web";
  inherit (sources.transmissionic) version src;

  nativeBuildInputs = [unzip];

  dontConfigure = true;
  dontBuild = true;

  unpackPhase = ''
    mkdir transmissionic
    unzip $src -d transmissionic
  '';

  installPhase = ''
    cp -r transmissionic/web $out
  '';

  meta = with lib; {
    description = "Transmissionic, but only WebUI";
    homepage = "https://github.com/6c65726f79/Transmissionic";
    license = licenses.mit;
  };
}
#

