{pkgs, ...}: {
  programs.go = {
    enable = true;
    goPath = ".local/go";
    goBin = ".local/go/bin";
  };

  home = {
    packages = with pkgs; [
      gopls
      gore
    ];
    sessionPath = [
      "$GOBIN"
    ];
  };
}
