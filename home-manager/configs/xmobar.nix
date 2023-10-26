{config, ...}:
with builtins; let
  colors = config.my.colors.base16;

  yMaring = config.my.marginBase;
  xMaring = yMaring * 2;
  mkFc = str: color: "<fc=#${color}>${str}</fc>";
  sep = mkFc " • " colors.base04;

  mkIconRun = iconName: unicode: '', Run Com "echo" ["<fn=2>\x${unicode}</fn>"] "${iconName}" 3600'';
  icons = [
    (mkIconRun "i_volume" "f028")
    (mkIconRun "i_ram" "f538")
    (mkIconRun "i_cpu" "f2db")
    (mkIconRun "i_time" "f017")
  ];
in {
  programs.xmobar = {
    enable = true;
    extraConfig = ''
      Config
        { font = "JetBrainsMono NF"
        , additionalFonts = [ "Font Awesome 6 Free Regular" ]
        , bgColor = "#${colors.base00}"
        , fgColor = "#${colors.base05}"
        , alpha = 240
        , position = Static { xpos = ${toString xMaring}, ypos = ${toString yMaring}, width = ${toString (2560 - xMaring * 2)}, height = 32 }
        , lowerOnStart = True
        , pickBroadest = False
        , persistent = False
        , hideOnStart = False
        , iconRoot = "."
        , allDesktops = True
        , overrideRedirect = True
        , commands =
          [
            Run XMonadLog
          , Run Cpu ["-L","3","-H","50", "--normal","green","--high","red", "-t", "<total>%"] 10
          , Run Memory ["-t","<usedratio>%"] 10
          , Run Volume "default" "Master" ["-t", "<volume>%"] 10
          , Run Date "%H:%M" "date" 10
          ${builtins.concatStringsSep "\n" icons}
          ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = " %XMonadLog% }{ %i_volume% %default:Master%${sep}%i_ram% %memory%${sep}%i_cpu% %cpu%${sep}%i_time% %date%  " }
    '';
  };
}
