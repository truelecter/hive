{pkgs, ...}: {
  homebrew.casks = [
    "1password"
  ];

  environment.systemPackages = [
    pkgs._1password-cli
  ];

  # Because of 1Password requirements
  system.activationScripts.postActivation.text = ''
    cp ${pkgs._1password-cli}/bin/op /usr/local/bin/op
  '';
}
