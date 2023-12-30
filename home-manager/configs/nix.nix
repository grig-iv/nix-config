{
  config,
  pkgs,
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

  my.shell.bookmarks.x = config.home.sessionVariables.NIXCONF;

  home = {
    packages = with pkgs; [
      alejandra
      nil
    ];

    sessionVariables = {
      NIXCONF = lib.mkDefault "/etc/nixos";
    };

    shellAliases = {
      x = "jump $NIXCONF";

      shm = "home-manager switch --flake $NIXCONF#$(whoami)@$(hostname)";
      snc = "sudo nixos-rebuild switch --flake $NIXCONF#$(hostname)";
    };

    stateVersion = "23.05"; # lock. do not change
  };

  systemd.user.startServices = "sd-switch";

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true; # Workaround for https://github.com/nix-community/home-manager/issues/2942
  };
}
