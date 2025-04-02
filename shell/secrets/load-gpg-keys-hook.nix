{pkgs, ...}: let
  gpg = "${pkgs.gnupg}/bin/gpg";
in {
  devshell.startup.load_gpg_keys.text = ''
    _sopsAddKey() {
      ${gpg} --quiet --import "$1"
      local fpr
      # only add the first fingerprint, this way we ignore subkeys
      fpr=$(${gpg} --with-fingerprint --with-colons --show-key "$1" \
            | awk -F: '$1 == "fpr" { print $10; exit }')
    }

    sopsImportKeysHook() {
      local dir="${toString ../../keys}"
      while IFS= read -r -d ''' key; do
        _sopsAddKey "$key"
      done < <(find -L "$dir" -type f \( -name '*.gpg' -o -name '*.asc' \) -print0)
    }

    sopsImportKeysHook
  '';
}
