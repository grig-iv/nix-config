{inputs, ...}: {
  nixpkgs.overlays = [
    inputs.grig-dwm.overlays.default
  ];

  services.xserver = {
    enable = true;
    windowManager.dwm = {
      enable = true;
    };
  };
}
