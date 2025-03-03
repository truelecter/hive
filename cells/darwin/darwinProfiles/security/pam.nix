{inputs, ...}: {
  imports = [
    inputs.cells.pam-reattach.darwinModules.pam
  ];

  security.pam.services.sudo_local = {
    enable = true;

    touchIdAuth = true;
    reattach = true;
  };

  # security.pam.enableSudoTouchIdAuthWithReattach = true;
}
