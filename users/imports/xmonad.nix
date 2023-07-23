{
  config,
  pkgs,
  ...
}: let
  colors = config.my.colors.base16;

  mkXColor = color: "(xmobarColor \"#${color}\" \"\")";
in {
  home.packages = with pkgs; [
    alacritty
    firefox
    telegram-desktop
    xclip
    feh
    maim
    picom-jonaburg
    pulsemixer
  ];

  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = pkgs.writeText "xmonad.hs" ''
      import XMonad

      import XMonad.Layout.NoBorders
      import XMonad.Layout.MultiToggle
      import XMonad.Layout.MultiToggle.Instances

      import XMonad.Layout.Spacing
      import XMonad.Actions.CycleWS
      import XMonad.Actions.SpawnOn
      import XMonad.Actions.WithAll
      import XMonad.Actions.Promote

      import XMonad.Util.EZConfig
      import XMonad.Util.Loggers
      import XMonad.Util.Ungrab
      import XMonad.Util.SpawnOnce
      import XMonad.Util.NamedScratchpad

      import XMonad.Hooks.DynamicLog
      import XMonad.Hooks.ManageDocks
      import XMonad.Hooks.ManageHelpers
      import XMonad.Hooks.EwmhDesktops
      import XMonad.Hooks.StatusBar
      import XMonad.Hooks.StatusBar.PP
      import XMonad.Hooks.RefocusLast (refocusLastLogHook)

      import qualified XMonad.StackSet as W
      import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))

      myTerminal = "alacritty"
      myBrowser = "firefox"
      myConfig = def
          { modMask    = mod4Mask
          , terminal   = myTerminal
          , workspaces = ["DEV", "WEB", "SYS", "MSG", "VM", "MISC"]
          , normalBorderColor = "#${colors.base03}"
          , focusedBorderColor = "#${colors.base0E}"
          , focusFollowsMouse  = False
          , clickJustFocuses = True
          , borderWidth = 2
          , layoutHook = smartBorders $ spacingWithEdge ${toString config.my.marginBase} $ myLayout
          , manageHook = myManageHook
          , startupHook = myStartupHook
          , logHook =  refocusLastLogHook >> nsHideOnFocusLoss myScratchPads
          }

      setRandomWallpapers = "feh --randomize --bg-fill --no-recurseve ${toString config.my.backgroundsDirPath}/*"

      myKeybindings =
          [ ("M-q", spawn "xmonad --restart")

          -- workspaces
          , ("M-<Page_Up>", prevWS)
          , ("M-<Page_Down>", nextWS)
          , ("M-S-<Page_Up>", shiftToPrev >> prevWS)
          , ("M-S-<Page_Down>", shiftToNext >> nextWS)

          -- screens
          , ("M-<Left>", prevScreen)
          , ("M-<Right>", nextScreen)
          , ("M-S-<Left>", shiftPrevScreen >> prevScreen)
          , ("M-S-<Right>", shiftNextScreen >> nextScreen)

          -- windows
          , ("M-<Up>",     windows W.focusUp)
          , ("M-<Down>",   windows W.focusDown)
          , ("M-m",        windows W.focusMaster)
          , ("M-S-<Up>",   windows W.swapUp)
          , ("M-S-<Down>", windows W.swapDown)
          , ("M-S-m",      windows W.swapMaster)

          , ("M-w", kill)
          , ("M-S-w", killOthers)

          , ("M-l",  sendMessage NextLayout)
          , ("M-<F11>",  sendMessage ToggleStruts)
          --, ("M-t f",  sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts)

          -- utils
          , ("M-S-s", spawn "maim -s | xclip -selection clipboard -t image/png")
          , ("M-u w", spawn setRandomWallpapers)
          , ("M-b t", spawn $ myBrowser ++ " --new-tab http://127.0.0.1:9091")

          -- Media
          , ("<XF86AudioLowerVolume>", spawn "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+")
          , ("<XF86AudioRaiseVolume>", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")

          -- rofi
          , ("M-<Space>", spawn "rofi -show drun")
          , ("M-p", spawn "rofi -show power-menu -modi power-menu:rofi-power-menu")
          , ("M-s", spawn "rofi-pulse-select source")
          , ("M-u e", spawn "rofi -show emoji")
          , ("M-u c", spawn "rofi -show calc")

          , ("M-<Return>", spawn myTerminal)
          , ("M-S-<Return>", namedScratchpadAction myScratchPads "term")
          , ("M-<Tab> m", namedScratchpadAction myScratchPads "mixer")
          ]


      myStartupHook = do
        spawnOnce "xrandr --output DP-0 --mode 2560x1440 --rate 144"
        spawnOnce "xinput --set-prop 14 'libinput Accel Speed' -0.5"
        spawnOnce "udiskie"
        spawnOnce "picom"
        spawnOnce setRandomWallpapers
        spawnOnOnce "WEB" myBrowser
        spawnOnOnce "SYS" myTerminal
        spawnOnOnce "MSG" "telegram-desktop"


      myManageHook = composeAll
          [ className =? "confirm"         --> doFloat
          , className =? "file_progress"   --> doFloat
          , className =? "dialog"          --> doFloat
          , className =? "download"        --> doFloat
          , className =? "mpv"             --> hasBorder False
          , className =? "error"           --> doFloat
          , className =? "Gimp"            --> doFloat
          , className =? "notification"    --> doFloat
          , className =? "pinentry-gtk-2"  --> doFloat
          , className =? "splash"          --> doFloat
          , className =? "toolbar"         --> doFloat
          , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat]
          <+> (isFullscreen --> doFullFloat)
          <+> (namedScratchpadManageHook myScratchPads)
          <+> manageSpawn
          <+> manageDocks


      myLayout = tiled ||| Mirror tiled ||| noBorders Full
        where
           tiled   = Tall nmaster delta ratio
           nmaster = 1
           ratio   = 1/2
           delta   = 3/100


      myScratchPads =
          [ NS "term" (myTerminal ++ " --title scratchpad") (title =? "scratchpad") (placeCenter 0.5 0.7)
          , NS "mixer" (spawnTermWith "pulsemixer") (title =? "pulsemixer") (placeCenter 0.5 0.7)
          ]
          where
            spawnTermWith command = myTerminal ++ " --title " ++ command ++ " --command " ++ command
            placeCenter w h = customFloating $ W.RationalRect l t w h
                     where
                       t = 0.5 - h / 2
                       l = 0.5 - w / 2


      myXmobarPP = def
          { ppSep             = ${mkXColor colors.base04} "  •  "
          , ppTitleSanitize   = xmobarStrip
          , ppCurrent         = wrap " " "" . xmobarBorder "Top" "#${colors.base0E}" 3 
          , ppHidden          = ${mkXColor colors.base05} . wrap " " ""
          , ppHiddenNoWindows = ${mkXColor colors.base03} . wrap " " ""
          , ppUrgent          = red500 . wrap (orange500 "!") (orange500 "!")
          , ppOrder           = \[ws, l, _, wins] -> [ws]
          , ppExtras          = [logTitles formatFocused formatUnfocused]
          }
        where
          formatFocused   = wrap (${mkXColor colors.base0E} "[") (${mkXColor colors.base0E} "]") . ${mkXColor colors.base05} . ppWindow
          formatUnfocused = wrap (${mkXColor colors.base03} "[") (${mkXColor colors.base03} "]") . ${mkXColor colors.base03}  . ppWindow
          ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30
          red500  = xmobarColor "#FA6464" ""
          orange500  = xmobarColor "#E3743C" ""

      myXmobarPP2 = def
          { ppSep             = magenta " • "
          , ppTitleSanitize   = xmobarStrip
          , ppCurrent         = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2
          , ppHidden          = white . wrap " " ""
          , ppHiddenNoWindows = lowWhite . wrap " " ""
          , ppUrgent          = red . wrap (yellow "!") (yellow "!")
          , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
          , ppExtras          = [logTitles formatFocused formatUnfocused]
          }
        where
          formatFocused   = wrap (white    "[") (white    "]") . magenta . ppWindow
          formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue    . ppWindow
          ppWindow :: String -> String
          ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

          blue, lowWhite, magenta, red, white, yellow :: String -> String
          magenta  = xmobarColor "#ff79c6" ""
          blue     = xmobarColor "#bd93f9" ""
          white    = xmobarColor "#f8f8f2" ""
          yellow   = xmobarColor "#f1fa8c" ""
          red      = xmobarColor "#ff5555" ""
          lowWhite = xmobarColor "#bbbbbb" ""

      main = xmonad
           . ewmhFullscreen
           . ewmh
           . withEasySB (statusBarProp "xmobar $XDG_CONFIG_HOME/xmobar/.xmobarrc" (pure myXmobarPP2)) defToggleStrutsKey
           $ myConfig `additionalKeysP` myKeybindings
    '';
  };
}
