{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  l = nixpkgs.lib // builtins;
  hosts = cell.nixosConfigurations;
  deploymentOverrides = {
    depsos = {
      targetPort = 2265;
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
