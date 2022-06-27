{...}: {
  sops.secrets.root-password = {
    key = "root";
    sopsFile = ./sops/user-passwords.yaml;
    neededForUsers = true;
  };
}
