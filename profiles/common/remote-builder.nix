{
  users.users.root = {
    openssh.authorizedKeys.keys = [
      (builtins.readFile ../../secrets/ssh/root_nas.pub)
    ];
  };
}
