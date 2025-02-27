{stdenvNoCC, ...}:
stdenvNoCC.mkDerivation {
  pname = "rk3566-bigtreetech-pi2-dtb";
  version = "6.1.43";

  src = ./_dt/6.1.43-btt-img;

  dontBuild = true;
  dontPatch = true;
  dontFixup = true;

  installPhase = ''
    mkdir -p $out/dtbs

    cp -r rockchip $out/dtbs/rockchip
  '';
}
