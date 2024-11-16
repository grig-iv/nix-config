{...}: {
  programs.bash = {
    enable = true;
    initExtra = ''
      # if [ -n ''${IN_NIX_SHELL+x} ]; then
      #   fish
      #   exit
      # fi

      bind -x '"\C-q":"exit"'
    '';
  };
}
