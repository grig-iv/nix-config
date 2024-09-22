{
  config,
  modulesPath,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "nvme"
      "usb_storage"
      "usbhid"
      "sd_mod"
    ];
    kernelModules = [ "kvm-intel" ];
  };

  fileSystems = {
    "/mnt/c" = {
      device = "/dev/sda2";
      fsType = "ntfs";
    };
  };

  nix.settings.max-jobs = 12;
  nixpkgs.hostPlatform = "x86_64-linux";

  networking.useDHCP = true;

  powerManagement.cpuFreqGovernor = "performance";
  hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;
}
