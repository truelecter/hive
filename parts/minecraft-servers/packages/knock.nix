{
  stdenv,
  lib,
  sources,
  # deps
  autoconf,
  automake,
  libpcap,
}:
stdenv.mkDerivation rec {
  pname = "knock";

  inherit (sources.knock) version src;

  nativeBuildInputs = [autoconf automake];

  buildInputs = [libpcap];

  preConfigure = ''
    autoreconf -fi
  '';

  meta = with lib; {
    description = "Port-knocking server/client.";
  };
}
