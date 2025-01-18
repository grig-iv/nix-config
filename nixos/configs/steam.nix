{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    steamcmd
    steam-tui
  ];

  # apparently fixes steam
  programs.nix-ld.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  hardware.graphics.enable32Bit = true; # Enables support for 32bit libs that steam uses
}
