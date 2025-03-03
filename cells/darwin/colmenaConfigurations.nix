{
  inputs,
  cell,
}: let
  inherit (inputs) haumea nixpkgs;
  l = nixpkgs.lib // builtins;
  hosts = cell.darwinConfigurations;
  deploymentOverrides = {
    tl-mm4 = {
      targetHost = "10.3.0.10";
    };
  };
in
  l.mapAttrs
  (
    name: value: {
      imports = [value];

      deployment =
        l.recursiveUpdate {
          targetHost = name;
          targetPort = 22;
          targetUser = "truelecter";
        } (
          if deploymentOverrides ? "${name}"
          then deploymentOverrides."${name}"
          else {}
        );
    }
  )
  hosts
