{ pkgs, inputs, lib, ...}:
let
  sopsPGPKeyDirs = lib.concatStringsSep " " [
    "${toString ./../..}/keys/hosts"
    "${toString ./../..}/keys/users"
  ];
  gpg = "${pkgs.gnupg}/bin/gpg";
in
{
  devshell.startup.load_gpg_keys = pkgs.lib.noDepEntry ''
    _sopsAddKey() {
      ${gpg} --quiet --import "$key"
      local fpr
      # only add the first fingerprint, this way we ignore subkeys
      fpr=$(${gpg} --with-fingerprint --with-colons --show-key "$key" \
            | awk -F: '$1 == "fpr" { print $10; exit }')
    }

    sopsImportKeysHook() {
      local dir
      for dir in ${sopsPGPKeyDirs}; do
        while IFS= read -r -d ''' key; do
          _sopsAddKey "$key"
        done < <(find -L "$dir" -type f \( -name '*.gpg' -o -name '*.asc' \) -print0)
      done
    }

    sopsImportKeysHook
  '';
}
