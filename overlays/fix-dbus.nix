self: super: {
  python39Packages = super.python39Packages.override {
    overrides = pfinal: pprev: {
      dbus-next = pprev.dbus-next.overridePythonAttrs (old: {
        # temporary fix for https://github.com/NixOS/nixpkgs/issues/197408
        checkPhase = builtins.replaceStrings ["not test_peer_interface"] ["not test_peer_interface and not test_tcp_connection_with_forwarding"] old.checkPhase;
      });
    };
  };
}
