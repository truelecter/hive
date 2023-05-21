{
  config,
  pkgs,
  lib,
  ...
}: let
  source = ./k3s-bootstrap;
  target = "/var/lib/rancher/k3s/server/manifests";
  # https://github.com/k3s-io/k3s/blob/master/tests/e2e/scripts/rancher.sh#L5
  script = pkgs.writeScript "k3s-populate" ''
    sleep 10
    cp -r "${source}" "${target}/k3s-bootstrap"
  '';
in {
  systemd.services.k3s-bootstrap = {
    description = "Populate k3s initial manifests";

    after = ["k3s.service"];
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash ${script}";
    };
  };
}
