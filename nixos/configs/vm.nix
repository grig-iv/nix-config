{...}: {
  boot.kernelModules = ["kvm-intel"];

  virtualisation.libvirtd.enable = true;

  programs.virt-manager.enable = true;

  users.extraGroups."libvirtd".members = [
    "grig"
    "grig-iv" # remove on reinstall
  ];
}
