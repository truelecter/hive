final: prev: rec {
  # keep sources this first
  sources = prev.callPackage (import ./sources/pkgs/generated.nix) {};
  sources-vscode-extensions = prev.callPackage (import ./sources/vscode/generated.nix) {};
  # then, call packages with `final.callPackage`
  tfenv = final.callPackage ./tfenv.nix {};
  transmissionic-web = final.callPackage ./transmissionic-web.nix {};
  libcamera-apps = final.callPackage ./libcamera-apps.nix {};
  rtsp-simple-server = final.callPackage ./rtsp-simple-server.nix {};
  moonraker = final.callPackage ./moonraker.nix {};
  klipper-screen = final.callPackage ./klipper-screen.nix {};
  mainsail = final.callPackage ./mainsail.nix {};
  # jemalloc = final.callPackage ./jemalloc.nix {};
  pam-reattach = final.callPackage ./pam-reattach.nix {};
  otf2bdf = final.callPackage ./otf2bdf.nix {};
  moonraker-telegram-bot = final.callPackage ./moonraker-telegram-bot.nix {};

  vscode-extensions = let
    lib = final.lib;
    buildVscodeExtension = name': value': let
      fullname = lib.removePrefix "\"" (lib.removeSuffix "\"" name');
      parts = lib.splitString "." fullname;
      publisher = builtins.elemAt parts 0;
      name = builtins.elemAt parts 1;
    in {
      "${publisher}"."${name}" = final.vscode-utils.extensionFromVscodeMarketplace {
        inherit publisher name;
        inherit (value') version;
        sha256 = value'.src.outputHash;
      };
    };
  in
    builtins.foldl' lib.recursiveUpdate prev.vscode-extensions (
      lib.mapAttrsToList buildVscodeExtension sources-vscode-extensions
    );
}
