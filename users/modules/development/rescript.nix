{pkgs, ...}: {
  home.packages = with pkgs; [nodejs_20 python3];
  programs.vscode.extensions = [pkgs.vscode-extensions.chenglou92.rescript-vscode];
}
