{...}: let
  apps = {
    main = [
      "git"
      "chezmoi"
      "lsd"
      "win32yank"
    ];
    extras = [
      "age"
      "bitwarden"
      "firefox"
      "flow-launcher"
      "gitextensions"
      "libreoffice"
      "meld"
      "neovide"
      "obsidian"
      "powertoys"
      "qmk-toolbox"
      "shareX"
      "slack"
      "stretchly"
      "SumatraPDF"
      "switcheroo"
      "vscodium"
      "wezterm"
      "windirstat"
    ];
    nonportable = ["wireguard-np"];
    nerd-fonts = ["JetBrainsMono-NF-Mono"];
  };
in {
}
