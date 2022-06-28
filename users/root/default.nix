{
  hmUsers,
  config,
  ...
}: {
  # home-manager.users = {inherit (hmUsers) truelecter;};

  users.users.root = {
    passwordFile = config.sops.secrets.root-password.path;
  };
}
