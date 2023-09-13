{
  inputs,
  cell,
}: {
  remote-builders = {
    sops.secrets = {
      remote-builder-pk = {
        sopsFile = ./sops/ssh/root_nas;
        format = "binary";
      };
    };
  };
}
