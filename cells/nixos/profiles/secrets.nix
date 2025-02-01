{...}: {lib, ...}: {
  sops.gnupg.sshKeyPaths = lib.mkDefault [
    "/etc/ssh/ssh_host_rsa_key"
  ];
}
