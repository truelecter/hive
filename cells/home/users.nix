{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std haumea;
  l = nixpkgs.lib // builtins;
  userProfiles = cell.userProfiles;
  homeModules = cell.homeModules;
  modulesImportables = l.attrValues homeModules;
in {
  darwin = {
    "andrii.panasiuk" = {pkgs, ...}: let
      home = "/Users/andrii.panasiuk";
    in {
      users.users."andrii.panasiuk".home = home;

      home-manager.users."andrii.panasiuk" = _: {
        imports =
          [
            userProfiles.workstation
            inputs.cells.darwin.homeProfiles.shell.iterm
            inputs.cells.darwin.homeProfiles.smart-card-fix
          ]
          ++ modulesImportables;

        programs.git.extraConfig = {
          user = {
            email = "andrew.panassiouk@gmail.com";
            name = "Andrii Panasiuk";
          };
        };

        home.stateVersion = "22.11";
      };

      system.defaults.dock.persistent-apps = [
        "/Applications/Arc.app"
        "/Applications/iTerm.app"
        "${pkgs.vscode}/Applications/Visual Studio Code.app"
        "/Applications/Telegram Desktop.app"
        "/Applications/Slack.app"
        "/System/Applications/Mail.app"
        "/System/Applications/Calendar.app"
        "/Applications/Cisco/Cisco Secure Client.app"
        "/Applications/Amazon Chime.app"
        "/Applications/OpenVPN Connect/OpenVPN Connect.app"
      ];

      system.defaults.dock.persistent-others = [];

      home-manager.backupFileExtension = ".bak";

      users.groups.keys.members = ["andrii.panasiuk"];

      # The filesystem path to which screencaptures should be written.
      system.defaults.screencapture.location = "${home}/Documents/Captures";
    };

    root = {...}: {
      users.users.root = {
        uid = 0;
        gid = 0;
      };
    };
  };

  nixos = rec {
    truelecter = {pkgs, ...}: {
      home-manager.users.truelecter = {
        imports = [userProfiles.minimal] ++ modulesImportables;

        programs.git.extraConfig = {
          user = {
            email = "andrew.panassiouk@gmail.com";
            name = "Andrii Panasiuk";
          };
        };

        home.stateVersion = "22.11";
      };

      programs.zsh.enable = true;

      users.users.truelecter = {
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = ["wheel" "docker"];

        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDYKTlyWIGFv0GlrysdzueaXSdHOYkm35OaWsshTr0dHehFZXwWKqXms2tELy9fec2W+kr1gVFuvJcSg9wZltYuHC2OGKXhl8YITYVjSQyqd6isfGdL/HTP4psrICcpBGjmxFR7pCUcjbpF02J/HS57YC1wMEruidIm7rhwHvXIIKfCTa5BYyDaY+xEmrqFyEK2EyJ9TanaYZRE34pd+UYY2A+uKmhR7DLb/o8VlCjE8yHrq2x+kpzFMamQ2Kz4OIFejBNnBsgWK5vTlRG4xpizIDJnunIvTnj2cQqcyMLEbeJ6WIO8KolG4RcMmV2iJhuFopCYrGsAfTNyn4TprHm8D1fw95UeVEF53fyRL/REyIqazPXiMPRtYV/eH2km65j3RW1T80fFo8ueFAuKJU6uTomDbbqSmU9SbBabjlZoJWqi8BMTyX5f3xreNkM6bplca/yAMNq5KMIOlSHanak0tbV+UK4TEjAcJJuqUIvWaG1JlWGaKFmXNmwnTpC8xQhE5Iv6wv07zhXyqEi9xIQLAT5pHmP0Rf/elKObOur1epTFEapUyQ6Xfx1QmrP4zBR2WhCP2WzJsM/fGsd2fk75eQQ3W6HPIe5tD4qKZeHMGD7Ar8JyqyiXFKGtaZq/pKpG8V9nlEbSznS1CuBtvWAlvx4IVBYXq6SKfO0MgM+6Dw== yubikey"
        ];
      };
    };

    truelecter-dev = {pkgs, ...}: {
      imports = [truelecter];

      home-manager.users.truelecter = {
        imports = [userProfiles.server-dev];
      };
    };

    root = {config, ...}: {
      users.users.root = {
        uid = 0;
        hashedPasswordFile = config.sops.secrets.root-password.path;
      };
    };
  };
}
