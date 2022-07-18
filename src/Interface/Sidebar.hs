module Interface.Sidebar where

import Data.String.Interpolate (i)
import Graphics.UI.Threepenny (Element, UI, id_, set, text, (#), (#+), (#.))
import qualified Graphics.UI.Threepenny as UI

sidebar :: UI Element
sidebar = sidebar #+ [title, menuList]
  where
    sidebar = UI.mkElement "aside" #. "column is-2"
    title =
      UI.p
        # set id_ "sidebar-title"
        #. "menu-label"
        # set text "Monad Trade"
    menuList =
      UI.ul
        # set id_ "menu"
        #. "menu-list"
        #+ [ menuEntry "home" "General" False,
             menuEntry "headphones-simple" "Audio" True,
             menuEntry "keyboard" "Hotkeys" False,
             menuEntry "code" "Macros" False
           ]
    itemLink children isActive =
      UI.li #+ [UI.a #. (if isActive then "is-active" else mempty) #+ children]
    menuEntry (icon :: String) name =
      itemLink
        [ UI.span #. "icon sidebar-icon" #+ [UI.mkElement "i" #. [i|fa fa-#{icon}|]],
          UI.span #. "sidebar-entry" # set text name
        ]
