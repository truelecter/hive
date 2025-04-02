{...}: {
  flake = {
    overlays.vscode-extensions = final: prev: {
      vscode-exts = (import ./generated.nix) {inherit (final) pkgs lib;};
    };
  };
}
