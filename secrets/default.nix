{...}: {
  sops.secrets = {
    root-password = {
      key = "root";
      sopsFile = ./sops/user-passwords.yaml;
      neededForUsers = true;
    };

    tailscale-key = {
      key = "tailscale";
      sopsFile = ./sops/keys.yaml;
    };
  };
}
