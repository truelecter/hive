{lib, ...}: {
  sops.gnupg.sshKeyPaths = lib.mkForce [
    "/etc/ssh/ssh_host_rsa_key"
  ];
}
