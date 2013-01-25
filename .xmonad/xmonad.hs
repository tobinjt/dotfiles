-- Enable XMonad in Gnome with:
-- gconftool-2 -s /desktop/gnome/session/required_components/windowmanager xmonad --type string
import Data.List
import XMonad
import XMonad.Config.Gnome
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import qualified XMonad.StackSet as StackSet
import XMonad.Util.EZConfig

-- This is mostly the default, with avoidStruts added to avoid the Gnome
-- panels, and the default changed from tiled to Full.
myLayout = avoidStruts (Full ||| tiled ||| Mirror tiled)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio
     -- The default number of windows in the master pane
     nmaster = 1
     -- Default proportion of screen occupied by master pane
     ratio   = 1/2
     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

myKeysToAdd =
    [
        -- other key mappings go here
        ("M-S-,", sendMessage (IncMasterN (-1)))
    ]
	++
    -- Make workspace switching non-greedy for dual-screen setups.
    -- http://www.haskell.org/haskellwiki/Xmonad/Frequently_asked_questions#Replacing_greedyView_with_view
	[ (otherModMasks ++ "M-" ++ [key], action tag)
	    | (tag, key)  <- zip myWorkspaces "123456789"
	    , (otherModMasks, action) <- [ ("", windows . StackSet.view)
					                 , ("S-", windows . StackSet.shift)]
	]

myKeysToRemove =
    [
        "M-."
    ]

myMouseBindingsToRemove =
    [
        (mod1Mask, button1),
        (mod1Mask, button2),
        (mod1Mask, button3)
    ]

main =
    xmonad $ gnomeConfig
    {
      focusFollowsMouse = True,
      layoutHook = myLayout,
      workspaces = myWorkspaces
      -- Make chrome go fully fullscreen: https://wiki.archlinux.org/index.php/Xmonad#Chromium.2FChrome_will_not_go_fullscreen
      -- Sadly Lucid doesn't have a recent enough version :(
      -- handleEventHook = fullscreenEventHook
    } `additionalKeysP` myKeysToAdd `removeKeysP` myKeysToRemove `removeMouseBindings` myMouseBindingsToRemove
