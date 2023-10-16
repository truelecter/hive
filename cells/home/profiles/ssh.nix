{
  inputs,
  cell,
}: _: let
  hostnames = builtins.attrNames inputs.cells.nixos.colmenaConfigurations;
in {
  home.file = {
    ".ssh/config" = {
      text = ''
        Include ~/.ssh/config.local

        Host ${builtins.concatStringsSep " " hostnames}
          User truelecter
          ForwardAgent yes

        Host depsos
          Port 2265
      '';
    };
  };
}
