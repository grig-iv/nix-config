{pkgs, ...}: {
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "nix-env";
        src = pkgs.fetchFromGitHub {
          owner = "lilyball";
          repo = "nix-env.fish";
          rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
          hash = "sha256-RG/0rfhgq6aEKNZ0XwIqOaZ6K5S4+/Y5EEMnIdtfPhk";
        };
      }
    ];

    shellInit = let
      extra-config = "$HOME/.config/fish/config-extra.fish";
    in ''
      test -e ${extra-config} && source ${extra-config}
    '';
  };
}
