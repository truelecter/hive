{
  inputs,
  cell,
}: let
  inherit (inputs.cells.common) overrides;
in
  {...}: {
    homebrew.casks = [
      "1password"
    ];

    environment.systemPackages = [
      overrides._1password
    ];

    # Because of 1Password requirements
    system.activationScripts.postActivation.text = ''
      cp ${overrides._1password}/bin/op /usr/local/bin/op
    '';
  }
