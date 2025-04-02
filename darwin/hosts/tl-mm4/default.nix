{
  inputs,
  profiles,
  suites,
  users,
  ...
}: {
  imports =
    suites.base
    ++ suites.editors
    ++ suites.system-preferences
    ++ [
      profiles.common.remote-builder
      profiles.common.remote-builders.x86
      profiles.common.remote-builders.aarch

      users.darwin.truelecter

      ./aarch-builder.nix
    ];

  _module.args = {
    inherit profiles;
    nixpkgs = inputs.nixos;
  };

  networking = {
    computerName = "TL-MM4";
    knownNetworkServices = [
      "Wi-Fi"
      "Thunderbolt Bridge"
      "Office VPN"
      "Community VPN"
      "Tailscale Tunnel"
    ];
  };

  system.stateVersion = 4;
}
