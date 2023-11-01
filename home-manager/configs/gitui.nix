{...}: {
  programs.gitui = {
    enable = true;
    keyConfig = ''
      (
          exit: Some(( code: Char('q'), modifiers: ( bits: 2,),)),
      )
    '';
    theme = ''
      (
          selected_tab: Reset,
          command_fg: Rgb(205, 214, 244),
          selection_bg: Rgb(88, 91, 112),
          selection_fg: Rgb(205, 214, 244),
          cmdbar_bg: Rgb(24, 24, 37),
          cmdbar_extra_lines_bg: Rgb(24, 24, 37),
          disabled_fg: Rgb(127, 132, 156),
          diff_line_add: Rgb(166, 227, 161),
          diff_line_delete: Rgb(243, 139, 168),
          diff_file_added: Rgb(249, 226, 175),
          diff_file_removed: Rgb(235, 160, 172),
          diff_file_moved: Rgb(203, 166, 247),
          diff_file_modified: Rgb(250, 179, 135),
          commit_hash: Rgb(180, 190, 254),
          commit_time: Rgb(186, 194, 222),
          commit_author: Rgb(116, 199, 236),
          danger_fg: Rgb(243, 139, 168),
          push_gauge_bg: Rgb(137, 180, 250),
          push_gauge_fg: Rgb(30, 30, 46),
          tag_fg: Rgb(245, 224, 220),
          branch_fg: Rgb(148, 226, 213)
      )
    '';
  };

  home.shellAliases = {
    g = "gitui";
  };
}
