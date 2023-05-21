{
  inputs,
  common,
}: {
  users.users.root = {
    openssh.authorizedKeys.keys = [
      inputs.cells.secrets.files.builder-ssh-key
    ];
  };
}
