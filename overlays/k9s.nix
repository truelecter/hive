final: prev: {
  k9s = prev.k9s.overrideAttrs (o: rec {
    tags =
      if prev.hostPlatform.isDarwin
      then (builtins.filter (x: x != "netgo") o.tags)
      else o.tags;

    doCheck = false;
  });
}
