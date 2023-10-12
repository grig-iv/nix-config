{
  config,
  pkgs,
  unstable,
  lib,
  ...
}: {
  programs = {
    home-manager.enable = true;
    vscode = {
      userSettings = {
        nix.enableLanguageServer = true;
        nix.serverPath = "nil";
      };
      extensions = [pkgs.vscode-extensions.jnoortheen.nix-ide];
    };
  };

  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  home = {
    packages = [
      pkgs.alejandra
      unstable.nil
    ];

    sessionVariables = {
      NIXCONF = lib.mkDefault "/etc/nixos";
    };

    shellAliases = {
      x = ''cd $NIXCONF & $EDITOR $(${pkgs.fd}/bin/fd -t f | ${pkgs.skim}/bin/sk --preview "${pkgs.bat}/bin/bat --color=always --style=numbers {}" )'';

      shm = "home-manager switch --flake $NIXCONF#${config.home.username}";
      snc = "sudo nixos-rebuild switch --flake $NIXCONF#nixos";
    };

    stateVersion = "23.05"; # lock. do not change
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true; # Workaround for https://github.com/nix-community/home-manager/issues/2942
  };
}
