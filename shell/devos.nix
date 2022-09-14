{
  pkgs,
  extraModulesPath,
  inputs,
  lib,
  ...
}: let
  inherit
    (pkgs)
    sops
    cachix
    editorconfig-checker
    mdbook
    nixUnstable
    nvfetcher-bin
    alejandra
    node2nix
    gnupg
    ;

  pkgWithCategory = category: package: {inherit package category;};
  devos = pkgWithCategory "devos";
  linter = pkgWithCategory "linter";
  docs = pkgWithCategory "docs";
in {
  _file = toString ./.;

  imports = [
    "${extraModulesPath}/git/hooks.nix"
    ./hooks
    ./sops.nix
  ];

  # tempfix: remove when merged https://github.com/numtide/devshell/pull/123
  devshell.startup.load_profiles = pkgs.lib.mkForce (pkgs.lib.noDepEntry ''
    # PATH is devshell's exorbitant privilige:
    # fence against its pollution
    _PATH=''${PATH}
    # Load installed profiles
    for file in "$DEVSHELL_DIR/etc/profile.d/"*.sh; do
      # If that folder doesn't exist, bash loves to return the whole glob
      [[ -f "$file" ]] && source "$file"
    done
    # Exert exorbitant privilige and leave no trace
    export PATH=''${_PATH}
    unset _PATH
  '');

  devshell.startup.cachix_watch = pkgs.lib.noDepEntry ''
    echo Do not forget cachix watch-store --compression-level 6 truelecter &
  '';

  commands =
    [
      (devos nixUnstable)
      (devos sops)
      (devos inputs.deploy.packages.${pkgs.system}.deploy-rs)
      (devos inputs.home.packages.${pkgs.system}.home-manager)
      (devos inputs.nixos-generators.packages.${pkgs.system}.nixos-generators)
      (devos node2nix)
      (devos gnupg)
      (devos cachix)

      {
        category = "devos";
        name = nvfetcher-bin.pname;
        help = nvfetcher-bin.meta.description;
        command = "cd $PRJ_ROOT/packages; ${nvfetcher-bin}/bin/nvfetcher -c ./sources.toml $@";
      }

      (linter editorconfig-checker)
      (linter alejandra)

      (docs mdbook)
    ]
    ++ lib.optional (pkgs.stdenv.hostPlatform.isLinux && !pkgs.stdenv.buildPlatform.isDarwin)
    (devos inputs.nixos-generators.defaultPackage.${pkgs.system});
}
