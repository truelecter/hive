{pkgs, ...}: {
  fonts.packages = with pkgs; [
    powerline-fonts
    dejavu_fonts
    (
      nerdfonts.override
      {
        fonts = ["Iosevka" "IosevkaTerm"];
      }
    )
  ];
}
