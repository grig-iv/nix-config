{
  pkgs,
  unstable,
  ...
}: {
  #TODO: add script that adds dotnet tools csharprepl, fantomas, etc

  home.packages = [
    pkgs.dotnet-sdk_7
    unstable.fsautocomplete
  ];

  home.sessionVariables = {
    CLI_TELEMETRY_OPTOUT = "true";
  };

  home.sessionPath = [
    "$HOME/.dotnet/tools"
  ];
}
