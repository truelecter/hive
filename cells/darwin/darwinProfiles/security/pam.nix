{inputs, ...}: {
  imports = [
    inputs.cells.pam-reattach.darwinModules.pam
  ];

  security.pam.enableSudoTouchIdAuthWithReattach = true;
}
