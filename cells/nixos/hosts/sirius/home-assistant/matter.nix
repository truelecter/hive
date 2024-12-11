{...}: let
  matter-version = "6.6.1";
in {
  virtualisation.oci-containers = {
    containers.matter-server = {
      volumes = [
        "/srv/home-assistant/matter:/data"
        "/run/dbus:/run/dbus:ro"
      ];
      environment = {
      };
      image = "ghcr.io/home-assistant-libs/python-matter-server:${matter-version}";
      extraOptions = [
        "--network=host"
        "--security-opt=apparmor=unconfined"
      ];
      cmd = [
        "--storage-path"
        "/data"
        # "--paa-root-cert-dir /data/credentials"
        # "--bluetooth-adapter 0"
      ];
    };
  };

  systemd.tmpfiles.rules = [
    "d '/srv/home-assistant/matter' 0775 root root - -"
  ];
}
