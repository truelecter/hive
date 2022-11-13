{
  lib,
  stdenv,
  pkg-config,
  freetype,
  sources,
}:
stdenv.mkDerivation rec {
  pname = "otf2bdf";
  version = "3.1";

  inherit (sources.otf2bdf) src;

  buildInputs = [pkg-config freetype];

  meta = with lib; {
    description = "Convert OpenType fonts to BDF fonts using the FreeType 2 renderer";
    homepage = "http://sofia.nmsu.edu/~mleisher/Software/otf2bdf/";
  };
}
