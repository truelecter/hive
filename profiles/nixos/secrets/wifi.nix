{
  sops.secrets = {
    xata-password-env = {
      key = "wireless290Env";
      sopsFile = ../../../secrets/wifi.yaml;
    };
    xata-password = {
      key = "wireless290Pw";
      sopsFile = ../../../secrets/wifi.yaml;
    };
  };
}
