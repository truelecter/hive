# modification of nixpkgs deviceTree.applyOverlays to ignore compatibility
# Derives from https://github.com/NixOS/nixos-hardware/blob/793de77d9f83418b428e8ba70d1e42c6507d0d35/raspberry-pi/4/apply-overlays-dtmerge.nix
{
  lib,
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
        cd "${base}"
        find . -type f -name '*.dtb' -print0 \
          | xargs -0 cp -v --no-preserve=mode --target-directory "$out" --parents

        for dtb in $(find "$out" -type f -name '*.dtb'); do
          dtbCompat=$(fdtget -t s "$dtb" / compatible 2>/dev/null || true)
          # skip files without `compatible` string
          # test -z "$dtbCompat" && continue

          ${flip (concatMapStringsSep "\n") overlays (o: ''
          overlayCompat="$(fdtget -t s "${o.dtboFile}" / compatible)"

          # skip incompatible and non-matching overlays
          #if [[ ! "$dtbCompat" =~ "$overlayCompat" ]]; then
          #  echo "Skipping overlay ${o.name}: incompatible with $(basename "$dtb")"
          #el
          # skip non-matching overlay
          if ${
            if ((o.filter or null) == null)
            then "false"
            else ''
              [[ "''${dtb//${o.filter}/}" ==  "$dtb" ]]
            ''
          }
          then
            echo "Skipping overlay ${o.name}: filter does not match $(basename "$dtb")"
          else
            echo -n "Applying overlay ${o.name} to $(basename "$dtb")... "
            mv "$dtb"{,.in}

            # dtmerge requires a .dtbo ext for dtbo files, otherwise it adds it to the given file implicitly
            dtboWithExt="$TMPDIR/$(basename "${o.dtboFile}").dtbo"
            cp -r ${o.dtboFile} "$dtboWithExt"

            dtmerge "$dtb.in" "$dtb" "$dtboWithExt"

            echo "ok"
            rm "$dtb.in" "$dtboWithExt"
          fi
        '')}

        done'';
    })
