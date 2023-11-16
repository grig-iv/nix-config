{
  pkgs,
  lib,
  ...
}: let
  tools = [
    "dotnet-fsharplint"
    "fantomas"
    "fsautocomplete"
  ];

  toolString = lib.concatStringsSep " " tools;
in {
  home = {
    packages = with pkgs; [dotnet-sdk_7];

    sessionVariables = {
      CLI_TELEMETRY_OPTOUT = "true";
      DOTNET_ROOT = pkgs.dotnet-sdk_7;
    };

    sessionPath = [
      "$HOME/.dotnet/tools"
    ];
  };

  programs.vscode.extensions = [pkgs.vscode-extensions.ionide.ionide-fsharp];
}
