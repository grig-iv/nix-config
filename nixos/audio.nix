{...}: {
  security.rtkit.enable = true; # need at least for telegram
  hardware.pulseaudio.enable = false; # should be disabled if pipewire.enable == true
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true; # needed for tidal cycles
  };
}
