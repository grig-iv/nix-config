{config, ...}: {
  services.syncthing = {
    enable = true;
    extraOptions = [
      "--no-default-folder"
    ];
  };
}
