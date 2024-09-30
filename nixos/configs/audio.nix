{pkgs, ...}: let
  pactl = "${pkgs.pulseaudio}/bin/pactl";
  audio-cycle-output = pkgs.writeShellScriptBin "audio-cycle-output" ''
    sinks=($(${pactl} list short sinks | awk '{print $2}'))
    current_sink=$(${pactl} info | grep 'Default Sink' | cut -d: -f2 | xargs)

    for i in "''${!sinks[@]}"; do
       if [[ "''${sinks[''$i]}" = "''${current_sink}" ]]; then
           current_index=''$i
           break
       fi
    done

    next_index=$(( (current_index + 1) % ''${#sinks[@]} ))

    ${pactl} set-default-sink ''${sinks[''$next_index]}

    ${pactl} list short sink-inputs | cut -f1 | while read stream; do
      ${pactl} move-sink-input "''$stream" ''${sinks[''$next_index]}
    done

    ${pkgs.ffmpeg}/bin/ffplay -v 0 -volume 50 -nodisp -autoexit ${../../assets/minecraft-item-pop.mp3}
  '';
in {
  environment.systemPackages = [audio-cycle-output];

  security.rtkit.enable = true; # need at least for telegram
  hardware.pulseaudio.enable = false; # should be disabled if pipewire.enable == true
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true; # needed for tidal cycles
  };
}
