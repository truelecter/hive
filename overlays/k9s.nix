final: prev: rec {
  k9s-latest = k9s;

  k9s = prev.buildGoModule rec {
    name = "k9s";
    version = "0.26.0";

    inherit (prev.k9s.drvAttrs) preCheck;
    inherit (prev.k9s) meta;
    inherit (prev.sources.k9s) src;

    ldflags = [
      "-s"
      "-w"
      "-X github.com/derailed/k9s/cmd.version=${version}"
      "-X github.com/derailed/k9s/cmd.commit=${src.rev}"
    ];

    vendorSha256 = "sha256-1FmhoLfTQSygAScbvABHZJO3611T7cfuCboyu2ShbNo=";

    doCheck = false;
  };
}
