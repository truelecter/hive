{
  sops.secrets = {
    k3s-token = {
      key = "token";
      sopsFile = ../../../secrets/k3s.yaml;
    };

    k3s-depsos-external-ip = {
      key = "depsosK3sEnv";
      sopsFile = ../../../secrets/k3s.yaml;
    };

    depsos-wg-pk = {
      key = "depsosWG";
      sopsFile = ../../../secrets/k3s.yaml;
    };
  };
}
