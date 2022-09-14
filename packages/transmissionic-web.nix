{
  pkgs,
  stdenvNoCC,
  lib,
  sources,
  inputs,
  fetchzip,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "transmissionic-web";
  version = "1.6.2";

  src = fetchzip {
    url = "https://github.com/6c65726f79/Transmissionic/releases/download/v1.6.2/Transmissionic-webui-v1.6.2.zip";
    sha256 = "159izwp6jc0css31m2ykm9z9c4ndg6dk0ajhcnafgswa3842wmxa";
  };

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';

  meta = with lib; {
    description = "Transmissionic, but only WebUI";
    homepage = "https://github.com/6c65726f79/Transmissionic";
    license = licenses.mit;
  };
}
#

