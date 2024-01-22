{
  writeShellApplication,
  klipper,
  python3,
  gnumake,
  ...
}:
writeShellApplication {
  name = "klipper-genconf";
  runtimeInputs = [
    python3
    gnumake
  ];
  text = ''
    CURRENT_DIR=$(pwd)
    CONFIG_FILE="$CURRENT_DIR/''${1:-config}"
    TMP=$(mktemp -d)
    make -C ${klipper.src} OUT="$TMP" KCONFIG_CONFIG="$CONFIG_FILE" menuconfig
    rm -rf "$TMP" "$CONFIG_FILE.old"
    printf "\nYour firmware configuration for klipper:\n\n"
    cat "$CONFIG_FILE"
  '';
}
