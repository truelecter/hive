{
  inputs,
  cell,
}: let
  inherit (inputs) haumea nixpkgs;
  l = nixpkgs.lib // builtins;
  hosts = cell.nixosConfigurations;
  overrides = {
    depsos = {
      deployment.targetPort = 2265;
    };
    # voron = {
    #   deployment.targetHost = "10.3.0.86";
    # };
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
  (l.filterAttrs (n: _: n != "octoprint") hosts)
