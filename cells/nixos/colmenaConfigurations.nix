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
# l.listToAttrs (
#   l.map
#   (
#     d: {
#       name = d.name;
#       value =
#         hosts."${d.name}"
#         // {
#           deployment = {
#             targetHost = d.name;
#             targetPort = 22;
#             targetUser = "truelecter";
#           };
#         }
#         // (
#           if overrides ? "${d.name}"
#           then overrides."${d.name}"
#           else {}
#         );
#     }
#   )
#   (
#     l.filter (d: d.type == "directory")
#     (
#       l.mapAttrsToList (k: v: {
#         name = k;
#         type = v;
#       })
#       (l.readDir ./hosts)
#     )
#   )
# )

