final: prev: {
  s5cmd = prev.s5cmd.overrideAttrs (o: rec {
    inherit (prev.sources.s5cmd) pname version src;

    # httptest: failed to listen on a port: listen tcp6 [::1]:0: bind: operation not permitted
    doCheck = false;
  });
}
