{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.grig.programs.fish;
in
{
  options.grig.programs.fish = {
    enable = mkEnableOption "fish";
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;

      shellAliases = {
          # Verbosity and settings that you pretty much just always are going to want.
          cp = "cp -iv";
          mv = "mv -iv";
          rm = "rm -vI";
          mkd = "mkdir -pv";

          # Colorize commands when possible.
          ls = "ls -hN --color=auto --group-directories-first";
          grep = "grep --color=auto";
          diff = "diff --color=auto";
          ccat = "highlight --out-format=ansi";
          ip = "ip -color=auto";

          # These common commands are just too long! Abbreviate them.
          g = "git";
          e = "$EDITOR";
          shdn = "shutdown -h now";

          # Edit shortcuts
          ehm = "$EDITOR $CHEZMOI/modules/home.nix";
          enc = "$EDITOR $CHEZMOI/modules/configuration.nix";
          exm = "chezmoi edit --apply $CONFIG/xmonad/xmonad.hs";
          exb = "chezmoi edit --apply $CONFIG/xmobar/xmobar.conf";
          env = "chezmoi edit --apply $CONFIG/nvim/lua";


          # Shortcuts
          shutdown = "sudo shutdown";
          reboot = "sudo reboot";
          rshm = "home-manager switch --flake /etc/nixos#${config.home.username}";
          rsnc = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";

          vpn-on = "wg-quick up $CONFIG/wireguard/peer.conf";
          vpn-off = "wg-quick down $CONFIG/wireguard/peer.conf";
          find-font = "fc-list | grep ";
      };

      shellAbbrs = {
          cdc = "cd $CHEZMOI";
      };

      shellInit = builtins.readFile ./prompt.fish;
    };
  };
}
