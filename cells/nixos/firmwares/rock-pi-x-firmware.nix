{
  stdenvNoCC,
  lib,
  sources,
  unzip,
  ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "rock-pi-x-firmware";

  inherit (sources.rock-pi-x-firmware) version src;

  dontConfigure = true;
  dontBuild = true;

  nativeBuildInputs = [unzip];

  unpackPhase = ''
    mkdir source
    unzip $src -d source
  '';

  installPhase = ''
    mkdir -p $out/lib/firmware/brcm

    cp source/BT_WIFI_Firmware/bt/* $out/lib/firmware/brcm
    cp source/BT_WIFI_Firmware/wifi/* $out/lib/firmware/brcm

    ln -s "$out/lib/firmware/brcm/brcmfmac43455-sdio.ROCK Pi-ROCK Pi X.txt" "$out/lib/firmware/brcm/brcmfmac43455-sdio.Radxa-ROCK Pi X.txt"
  '';

  meta = with lib; {
    description = "Rock Pi X firmware for WiFi and Bluetooth";
    homepage = "https://dl.radxa.com/rockpix/drivers/firmware/";
    platforms = platforms.unix;
  };
}
