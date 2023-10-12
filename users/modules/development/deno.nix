{pkgs, ...}: {
  home.packages = with pkgs; [deno];
  programs.vscode.extensions = with pkgs.vscode-extensions; [denoland.vscode-deno];
}
