{
  k9s,
  hostPlatform,
  ...
}:
k9s.overrideAttrs (o: rec {
  tags =
    if hostPlatform.isDarwin
    then (builtins.filter (x: x != "netgo") o.tags)
    else o.tags;

  doCheck = false;
})
