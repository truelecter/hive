final: prev: rec {
  # keep sources this first
  sources = prev.callPackage (import ./_sources/generated.nix) {};
  # then, call packages with `final.callPackage`
  tfenv = final.callPackage ./tfenv {};
  transmissionic-web = final.callPackage ./transmissionic-web {};
}
