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
      UI.ul #. "menu-list"
        #+ [ menuEntry "home" "General",
             menuEntry "headphones-simple" "Audio",
             menuEntry "keyboard" "Hotkeys",
             menuEntry "code" "Macros"
           ]
    itemLink children = UI.li #+ [UI.a #+ children]
    menuEntry (icon :: String) name =
      itemLink
        [ UI.span #. "icon sidebar-icon" #+ [UI.mkElement "i" #. [i|fa fa-#{icon}|]],
          UI.span #. "menu-option sidebar-entry" # set text name
        ]
