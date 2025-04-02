{
  security.pam.services.sudo_local = {
    enable = true;

    touchIdAuth = true;
    reattach = true;
  };

  # security.pam.enableSudoTouchIdAuthWithReattach = true;
}
