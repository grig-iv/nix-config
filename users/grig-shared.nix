{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib; {
  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  imports = [
    inputs.nix-colors.homeManagerModules.default

    ./modules/my.nix
    ./modules/nix.nix
    ./modules/lf
    ./modules/git.nix
    ./modules/gitui.nix
    ./modules/fish.nix
    ./modules/tmux.nix
    ./modules/neovim.nix
    ./modules/lua.nix
    ./modules/syncthing.nix
  ];

  home.packages = with pkgs; [
    htop
    wget
    curl
    unzip
    tldr
    exa
    zip
  ];

  home.sessionVariables = {
    EDITOR = mkDefault "nvim";
    CONFIG = mkDefault "$HOME/.config";
    CHEZMOI = mkDefault "$HOME/.local/share/chezmoi";
    NIXCONF = mkDefault "/etc/nixos";
    NVIMCONF = mkDefault "$CONFIG/nvim";
    EXTMIND = mkDefault "$HOME/extended-mind";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.shellAliases = {
    # Verbosity and settings that you pretty much just always are going to want.
    cp = "cp -ivr";
    mv = "mv -iv";
    rm = "rm -vI";
    mkdir = "mkdir -pv";

    # Colorize commands when possible.
    ls = "exa --icons";
    grep = "grep --color=auto";
    diff = "diff --color=auto";
    ccat = "highlight --out-format=ansi";
    ip = "ip -color=auto";

    # shortcuts
    e = "$EDITOR";
    x = "cd $NIXCONF & e";
    n = "cd $NVIMCONF & e";
    m = "cd ~/extended-mind & e index.norg";

    # nix
    shm = "home-manager switch --flake $NIXCONF#${config.home.username}";
    snc = "sudo nixos-rebuild switch --flake $NIXCONF#nixos";

    # utils
    vpn-on = "wg-quick up $CONFIG/wireguard/peer.conf";
    vpn-off = "wg-quick down $CONFIG/wireguard/peer.conf";
    find-font = "fc-list | grep ";
  };


  programs.fish = {
    functions.goToProject = ''
        set selected_folder (command ls -d ~/projects/*/ | fzf)

        if test -n "$selected_folder"
            cd "$selected_folder"
            $EDITOR 
        else
            echo "No folder selected."
        end
    '';

    shellInit = pkgs.lib.mkAfter ''
      bind \cp 'goToProject; commandline -f execute'
    '';
  };

  xdg.enable = true;
  programs.home-manager.enable = true;
  home.stateVersion = "23.05"; # lock. do not change

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true; # Workaround for https://github.com/nix-community/home-manager/issues/2942
  };
}
