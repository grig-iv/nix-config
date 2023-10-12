{
  pkgs,
  unstable,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = unstable.vscode;
    userSettings = {
      "files.autoSave" = "afterDelay";
      "extensions.experimental.affinity" = {
        "asvetliakov.vscode-neovim" = 1;
      };
      "editor" = {
        "fontFamily" = "'JetbrainsMono Nerd Font', 'monospace', monospace";
        "fontLigatures" = true;
        "bracketPairColorization.enabled" = true;
      };
    };
    extensions = with pkgs.vscode-extensions; [ms-vsliveshare.vsliveshare] ++ (with pkgs.vscode-marketplace; [nwolverson.ide-purescript]);
  };
}
