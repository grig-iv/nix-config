{
  pkgs,
  unstable,
  ...
}: {
  programs.go = {
    enable = true;
    goPath = ".local/go";
    goBin = ".local/go/bin";
  };

  home = {
    packages = with pkgs; [
      unstable.gopls
      gore
    ];
    sessionPath = [
      "$GOBIN"
    ];
  };
}
