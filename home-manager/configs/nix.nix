{
  config,
  pkgs,
  lib,
  ...
}: {
  programs = {
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

  my.shell.bookmarks = {
    "x" = config.home.sessionVariables.NIXCONF;
  };

  home = {
    packages = with pkgs; [
      alejandra
      nil
    ];

    sessionVariables = {
      "NIXCONF" = lib.mkDefault "/etc/nixos";
    };

    shellAliases = {
      "x" = "jump $NIXCONF";

      "shm" = lib.mkDefault "home-manager switch --flake $NIXCONF#$(whoami)@$(hostname)";
      "snc" = "sudo nixos-rebuild switch --flake $NIXCONF#$(hostname)";
    };
  };

  systemd.user.startServices = "sd-switch";
}
