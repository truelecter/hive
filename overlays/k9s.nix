final: prev: {
  k9s = prev.k9s.overrideAttrs (o: let
    filteredTags = builtins.filter (x: x != "netgo") o.tags;
    tags =
      if prev.hostPlatform.isDarwin
      then filteredTags
      else (filteredTags ++ ["netgo"]);
  in rec {
    inherit tags;
    version = "${o.version}";
  });
}
