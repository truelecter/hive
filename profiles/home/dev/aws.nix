{pkgs, ...}: {
  home.packages = with pkgs; [
    s5cmd
    awscli2
    ssm-session-manager-plugin
    amazon-ecr-credential-helper
  ];
}
