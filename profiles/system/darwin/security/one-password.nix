{
  self,
  config,
  lib,
  pkgs,
  ...
}: {
  homebrew.casks = [
    "1password"
  ];

  environment.systemPackages = [
    pkgs._1password
  ];

  # Because of 1Password requirements
  system.activationScripts.postActivation.text = ''
    cp ${pkgs._1password}/bin/op /usr/local/bin/op
  '';
}
