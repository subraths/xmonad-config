import XMonad

import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Ungrab
import XMonad.Actions.CycleWS (toggleWS)
import XMonad.Layout.ToggleLayouts (ToggleLayout(..), toggleLayouts)
import XMonad.Layout.NoBorders (noBorders)
import XMonad.Layout.Fullscreen (fullscreenManageHook, fullscreenFull, fullscreenEventHook)

main :: IO ()
main = xmonad $ def
    { modMask = myModMask
    , borderWidth = myBorderWidth
    , terminal = myTerminal
    , layoutHook = myLayoutHook
    , manageHook = myManageHook
    , handleEventHook = myHandleEventHook
    , startupHook = myStartupHook
    , focusFollowsMouse = False
    }
  `additionalKeysP`
    [ ("M-p", spawn "dmenu_run -hp google-chrome-stable,transmission-gtk,thunar,Postman")
    , ("<Print>", unGrab *> spawn "scrot -s")
    , ("M-b"  , spawn "google-chrome-stable")
    , ("M-S-<Return>", spawn "thunar")
    , ("M-<Return>", spawn "st")
    , ("M-q", kill)
    , ("M-S-r", spawn "xmonad --recompile && xmonad --restart")
    , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -10%")
    , ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +10%")
    , ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    , ("M-<Tab>", toggleWS)
    , ("M-f", sendMessage ToggleLayout)
    ]

myModMask = mod1Mask
myTerminal = "st"
myBorderWidth = 0

myLayoutHook = toggleLayouts (noBorders Full) $ Tall 1 (3/100) (1/2) ||| Full

myManageHook = fullscreenManageHook <+> manageHook def

myHandleEventHook = fullscreenEventHook <+> handleEventHook def

--startuphook
myStartupHook :: X ()
myStartupHook = do
  --spawn "~/.config/xmonad/scripts/pipes.sh &"
  --spawn "~/.config/xmonad/scripts/volume-pipe.sh &"
  --spawn "~/.config/xmonad/scripts/backlight-pipe.sh &"
   spawn "~/.xmonad/autostart.sh &"
