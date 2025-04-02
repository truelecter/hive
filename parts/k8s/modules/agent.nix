{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
with lib; let
  cfg = config.tl.k8s.agent;
in {
  options.tl.k8s.agent = {
    enable = mkEnableOption "Kubernetes agent";

    serverAddr = mkOption {
      type = types.str;
      description = "Kubernetes control plane address";
    };

    tokenFile = mkOption {
      type = types.str;
      description = "Path to k3s token file";
    };

    configPath = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = "File path containing the k3s YAML config. This is useful when the config is generated (for example on boot).";
    };

    extraFlags = mkOption {
      type = types.str;
      default = "";
      description = "Extra options for k3s";
    };
  };

  config = mkIf cfg.enable {
    services.k3s = {
      enable = true;
      role = "agent";
      inherit (cfg) tokenFile serverAddr;
      extraFlags = "--container-runtime-endpoint unix:///run/containerd/containerd.sock ${cfg.extraFlags}";
      # --node-ip ${config.networking.doctorwho.currentHost.ipv4} --snapshotter=zfs
    };

    systemd.services.k3s = {
      wants = ["containerd.service"];
      after = ["containerd.service"];
    };

    virtualisation.containerd = {
      enable = true;

      settings = {
        version = 2;
        plugins."io.containerd.grpc.v1.cri" = {
          cni.conf_dir = "/var/lib/rancher/k3s/agent/etc/cni/net.d/";
          # FIXME: upstream
          cni.bin_dir = "${pkgs.runCommand "cni-bin-dir" {} ''
            mkdir -p $out
            ln -sf ${pkgs.cni-plugins}/bin/* ${pkgs.cni-plugin-flannel}/bin/* $out
          ''}";
        };
      };
    };
  };
}
