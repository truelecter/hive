# modification of nixpkgs deviceTree.applyOverlays to ignore compatibility
# Derives from https://github.com/NixOS/nixos-hardware/blob/793de77d9f83418b428e8ba70d1e42c6507d0d35/raspberry-pi/4/apply-overlays-dtmerge.nix
{
  lib,
  stdenvNoCC,
  dtc,
}:
with lib; (base: overlays':
    stdenvNoCC.mkDerivation {
      name = "device-tree-overlays";
      nativeBuildInputs = [dtc];
      buildCommand = let
        overlays = lib.toList overlays';
      in ''
        mkdir -p $out
        cd "${base}"
        find -L . -type f -name '*.dtb' -print0 \
          | xargs -0 cp -v --no-preserve=mode --target-directory "$out" --parents

        for dtb in $(find "$out" -type f -name '*.dtb'); do
          ${lib.flip (lib.concatMapStringsSep "\n") overlays (o: ''
          echo -n "Applying overlay ${o.name} to $(basename "$dtb")... "
          mv "$dtb"{,.in}
          fdtoverlay -v -o "$dtb" -i "$dtb.in" "${o.dtboFile}"
          echo "ok"
          rm "$dtb.in"
        '')}

        done
      '';
    })
