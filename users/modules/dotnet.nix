{
  pkgs,
  unstable,
  ...
}: {
  home.packages = [
    pkgs.dotnet-sdk_7
    unstable.fsautocomplete
  ];

  home.sessionVariables = {
    CLI_TELEMETRY_OPTOUT = "true";
  };
}
