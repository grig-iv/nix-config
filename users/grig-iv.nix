{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default

    ./grig-shared-desktop.nix

    ./modules/awesome.nix
    ./modules/tidal-cycles.nix
    ./modules/notes.nix
    ./modules/development/dotnet.nix
    ./modules/development/ocaml.nix
    ./modules/development/rescript.nix
    ./modules/development/purescript.nix
  ];

  home.packages = with pkgs; [
    qbittorrent
    remmina
    diskonaut

    discocss
    discord
  ];

  programs = {
    tmate.enable = true;
  };
}
