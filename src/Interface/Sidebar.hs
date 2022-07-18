module Interface.Sidebar where

import Data.Functor (void)
import Data.List (singleton)
import Data.String.Interpolate (i)
import Graphics.UI.Threepenny (Element, UI, class_, element, id_, on, set, text, (#), (#+), (#.))
import qualified Graphics.UI.Threepenny as UI
import UnliftIO (atomically, newTVarIO, swapTVar)

data SidebarEvent
  = GeneralPage
  | AudioPage
  | HotkeyPage
  | MacroPage

mkSidebar :: (SidebarEvent -> UI ()) -> UI Element
mkSidebar emit = sidebar #+ [title, menuList]
  where
    sidebar = UI.mkElement "aside" #. "column is-2"
    title =
      UI.p
        # set text "Monad Trade"
        # set id_ "sidebar-title"
        #. "menu-label"
    menuEntry name (icon :: String) =
      UI.a
        #+ [ UI.span #. "icon sidebar-icon" #+ [UI.mkElement "i" #. [i|fa fa-#{icon}|]],
             UI.span #. "sidebar-entry" # set text name
           ]
    menuList = do
      generalEntry <- menuEntry "General" "home" # set class_ "is-active"
      activeEntry <- newTVarIO generalEntry
      let register entry event = on UI.click entry . const $ do
            lastEntry <- atomically $ swapTVar activeEntry entry
            void $ element lastEntry # set class_ mempty
            void $ element entry # set class_ "is-active"
            emit event
          mkEntry (name, icon, event) = do
            entry <- menuEntry name icon
            register entry event
            return entry
          entryData =
            [ ("Audio", "home", AudioPage),
              ("Hotkeys", "keyboard", HotkeyPage),
              ("Macros", "code", MacroPage)
            ]
      register generalEntry GeneralPage
      entries <- (generalEntry :) <$> traverse mkEntry entryData
      UI.ul # set id_ "menu" #. "menu-list" #+ ((UI.li #+) . singleton . element <$> entries)