{
  self,
  exts,
  ...
}:
exts.conform {
  commit = {
    header = {
      length = 89;
      imperative = true;
    };
    body.required = false;
    gpg.required = true;
    maximumOfOneCommit = false;
    conventional = {
      types = [
        "fix"
        "feat"
        "build"
        "chore"
        "ci"
        "docs"
        "style"
        "refactor"
        "test"
      ];
      scopes =
        [
          "ci"
          "flake"
          "repo"
        ]
        ++ (builtins.attrNames self.nixosConfigurations)
        ++ (builtins.attrNames self.darwinConfigurations);
      descriptionLength = 72;
    };
  };
}
