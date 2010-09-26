import XMonad


-- import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.SetWMName

myLogHook::X()
myLogHook = fadeInactiveLogHook fadeAmount
    where fadeAmount = 0x99999999

myManageHook = composeAll [
      className =? "Gimp" --> doFloat
    , className =? "Vlc" --> doFloat
    , className =? "gxine" --> doFloat
    , className =? "pidgin" --> doFloat
               ]

main = do
  xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmonad/xmobar"
  xmonad $ defaultConfig
		{ manageHook	= manageDocks <+>myManageHook <+>
                                  manageHook defaultConfig
		, startupHook	= setWMName "LG3D"
		, layoutHook	= avoidStruts $ layoutHook defaultConfig
		, logHook	= (dynamicLogWithPP $ xmobarPP {
                                    ppOutput = hPutStrLn xmproc
                                  , ppTitle = xmobarColor "green" "" . shorten 50
                                  } ) >> myLogHook
		, modMask	= mod4Mask
                , terminal = "urxvtc"
		} `additionalKeys`
                [((mod4Mask .|. shiftMask, xK_z),
                  spawn "xscreensaver-command -lock"),
                 ((controlMask, xK_Print), spawn "scrot -s"),
                 ((0, xK_Print), spawn "scrot")
                ]
