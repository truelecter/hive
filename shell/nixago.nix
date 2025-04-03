{
  self,
  lib,
  inputs,
  ...
}: {
  perSystem = {
    config,
    system,
    inputs',
    pkgs,
    ...
  }: let
    nixago = inputs.nixago.lib.${system};

    exts = lib.pipe ["conform" "ghsettings" "lefthook"] [
      (builtins.map (name: {
        inherit name;
        value = inputs.nixago-exts.${name}.${system};
      }))
      lib.listToAttrs
    ];
  in {
    devshells.default = {
      packages = [
        pkgs.lefthook
        pkgs.treefmt
        pkgs.conform
      ];

      devshell.startup.nixago.text = lib.pipe ./nixago [
        self.lib.rakeLeaves
        builtins.attrValues
        (builtins.map (cfg: self.lib.importAttrOrFunction cfg {inherit self exts pkgs lib;}))
        nixago.makeAll
        (v: v.shellHook)
      ];
    };
  };
}
