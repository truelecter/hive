{
  sops.secrets = {
    remote-builder-pk = {
      sopsFile = ../../../secrets/ssh/root_nas;
      format = "binary";
      group = "wheel";
    };
  };
}
