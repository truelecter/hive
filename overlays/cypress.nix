final: prev: {
  cypress = prev.cypress.overrideAttrs (o: {
    src =
      if prev.hostPlatform.isAarch64
      then prev.sources.cypress-aarch64.src
      else o.src;

    meta.platforms = ["x86_64-linux" "aarch64-linux"];
  });
}
