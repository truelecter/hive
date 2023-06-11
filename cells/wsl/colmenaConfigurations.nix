{
  inputs,
  cell,
}: let
  inherit (inputs) haumea nixpkgs;
  l = nixpkgs.lib // builtins;
  hosts = cell.nixosConfigurations;
  overrides = {
  };
in
  l.mapAttrs
  (
    name: value:
      value
      // (
        l.recursiveUpdate
        {
          deployment = {
            targetHost = name;
            targetPort = 22;
            targetUser = "truelecter";
          };
        }
        (
          if overrides ? "${name}"
          then overrides."${name}"
          else {}
        )
      )
  )
  hosts
