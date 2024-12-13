{
  inputs,
  cell,
}: let
  inherit (inputs) haumea nixpkgs;
  l = nixpkgs.lib // builtins;
  hosts = cell.nixosConfigurations;
  deploymentOverrides = {
    depsos = {
      targetPort = 2265;
    };
    sirius = {
      targetHost = "10.3.0.23";
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
