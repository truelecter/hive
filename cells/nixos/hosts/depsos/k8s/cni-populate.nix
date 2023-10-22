{
  config,
  pkgs,
  lib,
  ...
}: let
  script = pkgs.writeScript "cni-populate" ''
    ln -sf ${pkgs.cni-plugins}/bin/* ${pkgs.cni-plugin-flannel}/bin/* /opt/cni/bin
  '';
in {
  systemd.services.cni-bootstrap = {
    description = "Populate CNI plugins";

    before = ["k3s.service"];
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash ${script}";
    };
  };
}
