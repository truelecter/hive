{
  suites,
  profiles,
  ...
}: {
  imports =
    suites.base
    ++ suites.remote-dev
    ++ [
      profiles.networking.tailscale
    ]
    ++ [
      ./hardware-configuration.nix
      ./minecraft-servers.nix
    ];

  systemd.services.NetworkManager-wait-online.enable = false;

  services.vnstat.enable = true;

  system.stateVersion = "22.11";

  # for remote builds
  users.users.root = {
    openssh.authorizedKeys.keys = [
      (builtins.readFile ./../../../secrets/sops/ssh/root_nas.pub)
    ];
  };
}
