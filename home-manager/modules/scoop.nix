{
  config,
  lib,
  ...
}:
with lib; let
  apps = {
    main = [
      "git"
      "lsd" # remove maybe?
      "win32yank"
    ];
    extras = [
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

  addBuckets = concatStrings (
    map (bucket: "scoop bucket add ${bucket};\n") (attrNames apps)
  );

  powershell = "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe";

  toPowershellCmd = cmd: ''${powershell} -C "${cmd}"'';
in {
}
