{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
with lib; let
  cfg = config.tl.k8s.server;
in {
  options.tl.k8s.server = {
    enable = mkEnableOption "Kubernetes server";

    tokenFile = mkOption {
      type = types.str;
      description = "Path to k3s token file";
    };

    serverAddr = mkOption {
      type = types.str;
      default = "";
      description = "Kubernetes control plane address";
    };

    disableAgent = mkOption {
      type = types.bool;
      default = false;
      description = "Only run the server";
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
    networking.firewall.allowedTCPPorts = [6443];

    services.k3s = {
      enable = true;

      inherit (cfg) tokenFile serverAddr;
      role = "server";

      inherit (cfg) configPath disableAgent;

      extraFlags = "--container-runtime-endpoint unix:///run/containerd/containerd.sock ${cfg.extraFlags}";
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
          cni.conf_dir = mkDefault "/etc/cni/net.d";
          cni.bin_dir = mkDefault "/opt/cni/bin";
        };
      };
    };
  };
}
