# TODO: add delta
{config, ...}: let
  colors = config.my.colors;
in {
  home.shellAliases.g = "lazygit";

  programs = {
    lazygit = {
      enable = true;
      settings = {
        disableStartupPopups = true;
        keybinding = {
          universal = {
            quit = "<c-q>";
            prevTab = "<left>";
            nextTab = "<right>";
            prevBlock = "<pgup>";
            nextBlock = "<pgdown>";
            scrollUpMain = "<home>";
            scrollDownMain = "<end>";
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
            activeBorderColor = [colors.accent "bold"];
            inactiveBorderColor = [colors.overlay0];
            optionsTextColor = [colors.primary];
            selectedLineBgColor = [colors.surface0];
            cherryPickedCommitBgColor = [colors.surface1];
            cherryPickedCommitFgColor = [colors.accent];
            unstagedChangesColor = [colors.critical];
            defaultFgColor = [colors.text];
            searchingActiveBorderColor = [colors.yellow];
          };
        };
      };
    };
  };
}
