{
  home.file = {
    ".ssh/config" = {
      text = ''
        Include ~/.ssh/config.local

        Host oracle depsos hyperos octoprint
          User truelecter
          ForwardAgent yes

        Host depsos
          Port 2265
      '';
    };
  };
}
