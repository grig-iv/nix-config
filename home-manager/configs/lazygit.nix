# https://github.com/jesseduffield/lazygit/
# TODO: add delta
{...}: {
  home.shellAliases.g = "lazygit";

  programs = {
    lazygit = {
      enable = true;
      settings = {
        disableStartupPopups = true;
        keybinding = {
          universal = {
            quit = "<c-q>";
            # nextTab = "<c-pgup>";
            # prevTab = "<c-pgdown>";
          };
        };
        gui = {
          nerdFontsVersion = "3";
          border = "rounded";
          showRandomTip = false;
          showCommandLog = false;
          showFileTree = false;
          showBottomLine = false;
          showListFooter = false;
          theme = {
            activeBorderColor = ["#89dceb" "bold"];
            inactiveBorderColor = ["#a6adc8"];
            optionsTextColor = ["#89b4fa"];
            selectedLineBgColor = ["#313244"];
            cherryPickedCommitBgColor = ["#45475a"];
            cherryPickedCommitFgColor = ["#89dceb"];
            unstagedChangesColor = ["#f38ba8"];
            defaultFgColor = ["#cdd6f4"];
            searchingActiveBorderColor = ["#f9e2af"];
          };
        };
      };
    };
  };
}
