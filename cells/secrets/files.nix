{
  inputs,
  cell,
}: let
  inherit (inputs) haumea nixpkgs;
  l = nixpkgs.lib // builtins;
  cells = inputs.cells;
in {
  builder-ssh-key = builtins.readFile ./sops/ssh/root_nas.pub;
}
