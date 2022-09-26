final: prev: {
  klipper = prev.klipper.overrideAttrs (o: rec {
    inherit (prev.sources.klipper) pname version src;
  });
}
