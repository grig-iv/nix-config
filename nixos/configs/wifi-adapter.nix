{
  unstable,
  config,
  ...
}: {
  environment.systemPackages = with unstable; [
    usbutils
    impala
  ];

  boot.extraModulePackages = with config.boot.kernelPackages; [
    rtl8192eu
  ];

  networking.wireless.iwd.enable = true;
}
