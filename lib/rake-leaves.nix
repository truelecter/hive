{
  inputs,
  lib,
}: let
  haumea = inputs.haumea.lib;
  loader = lib.const lib.id;
  transformer = _cursor: dir: dir.default or dir;
in
  src: haumea.load {inherit src loader transformer;}
