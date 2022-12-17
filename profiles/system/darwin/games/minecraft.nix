{
  self,
  config,
  lib,
  pkgs,
  ...
}: let
  prismlauncher_5_2 = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/Homebrew/homebrew-cask/92d3fddc6508349086a768341a3e93a3256797a6/Casks/prismlauncher.rb";
    downloadToTemp = true;
    recursiveHash = true;
    sha256 = "sha256-YkSCacF/D8Glci1Ytx+NQPJvvgft5SoE54Z2L+6ofSc=";
    postFetch = ''
      install -D $downloadedFile $out/prismlauncher.rb
    '';
  };
in {
  homebrew.casks = [
    # "prismlauncher"
    "zulu8"
    "zulu17"
  ];

  # until fix for version 6.0 on Apple Silicon
  homebrew.extraConfig = ''
    cask "${prismlauncher_5_2}/prismlauncher.rb"
  '';
}
