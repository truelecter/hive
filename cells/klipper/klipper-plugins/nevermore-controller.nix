{
  lib,
  stdenvNoCC,
  sources,
  ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "nevermore-controller";

  inherit (sources.klipper-nevermore-controller) version src;

  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/lib/extras
    cp -r ./klipper/*.py $out/lib/extras/
    cp -r ./tools $out/lib/
  '';

  passthru.klipper = {
    config = false;
    extras = true;
    pythonDependencies = p: with p; [janus bleak typing-extensions];
  };

  meta = with lib; {
    description = "Nevermore filter Klipper integration";
    platforms = platforms.linux;
    homepage = "https://github.com/SanaaHamel/nevermore-controller";
    license = licenses.gpl3Only;
  };
}
