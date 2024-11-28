{...}: let
  cmd = x: ''bash -c "echo '${x}' > /dev/tcp/127.0.0.1/10005"'';
in {
  services.sxhkd.keybindings = {
    "super + alt + ctrl + q" = cmd "quit";
    "super + alt + q" = cmd "kill-client";
    "super + alt + f" = cmd "full-screen";

    "super + Up" = cmd "focus -p";
    "super + Down" = cmd "focus -n";

    "super + ctrl + Prior" = cmd "go-to-tag -p";
    "super + ctrl + Next" = cmd "go-to-tag -n";

    "super + ctrl + shift + Prior" = cmd "move-to-tag -p";
    "super + ctrl + shift + Next" = cmd "move-to-tag -n";

    "super + t" = cmd "go-to-win-or-spawn org.wezfu wezterm";
    "super + f" = cmd "go-to-win-or-spawn firefox firefox";
    "super + s" = cmd "go-to-win-or-spawn TelegramDesktop telegram-desktop";
  };
}
