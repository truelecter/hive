# modification of nixpkgs deviceTree.applyOverlays to resolve https://github.com/NixOS/nixpkgs/issues/125354
# https://github.com/NixOS/nixpkgs/blob/master/pkgs/os-specific/linux/device-tree/default.nix
{
  lib,
  pkgs,
  stdenvNoCC,
  dtc,
  libraspberrypi,
}:
with lib; (base: overlays':
    stdenvNoCC.mkDerivation {
      name = "device-tree-overlays";
      nativeBuildInputs = [dtc libraspberrypi];
      buildCommand = let
        overlays = toList overlays';
      in ''
        mkdir -p $out
        cd ${base}
        find . -type f -name '*.dtb' -print0 \
          | xargs -0 cp -v --no-preserve=mode --target-directory $out --parents
        for dtb in $(find $out -type f -name '*.dtb'); do
          dtbCompat="$( fdtget -t s $dtb / compatible )"
          ${flip (concatMapStringsSep "\n") overlays (o: ''
          # Disable compatibility check for now
          # overlayCompat="$( fdtget -t s ${o.dtboFile} / compatible )"
          # overlayCompat in dtbCompat
          #if [[ "$dtbCompat" =~ "$overlayCompat" ]]; then
          echo "Applying overlay ${o.name} to $( basename $dtb )"
          mv $dtb{,.in}
          cp ${o.dtboFile} $dtb.dtbo
          echo dtmerge "$dtb.in" "$dtb" "$dtb.dtbo";
          dtmerge "$dtb.in" "$dtb" "$dtb.dtbo";
          rm $dtb.in "$dtb.dtbo"
          #fi
        '')}
        done
      '';
    })
