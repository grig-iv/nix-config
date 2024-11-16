{...}: let
  cmd = x: ''bash -c "echo '${x}' > /dev/tcp/127.0.0.1/10005"'';
in {
  services.sxhkd.keybindings = {
    "super + alt + ctrl + q" = cmd "quit";
    "super + alt + q" = cmd "kill-client";

    "super + ctrl + Prior" = cmd "go-to-tag -p";
    "super + ctrl + Next" = cmd "go-to-tag -n";

    "super + ctrl + shift + Prior" = cmd "move-to-tag -p";
    "super + ctrl + shift + Next" = cmd "move-to-tag -n";
  };
}
