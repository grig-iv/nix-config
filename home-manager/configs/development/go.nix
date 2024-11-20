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

  programs.fish.shellAbbrs = {
    "gmt" = "go mod tidy";
    "gmi" = "go mod init";
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
