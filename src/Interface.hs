module Interface where

import Data.Functor (void)
import Data.List (singleton)
import Graphics.UI.Threepenny (Element, UI, children, element, id_, set, text, (#), (#+), (#.))
import qualified Graphics.UI.Threepenny as UI
import Interface.Page.Audio (audioPage)
import Interface.Page.General (generalPage)
import Interface.Page.Hotkey (hotkeyPage)
import Interface.Page.Macro (macroPage)
import Interface.Sidebar (SidebarEvent (..), mkSidebar)

interface :: UI Element
interface = do
  let title = UI.p # set id_ "main-title" #. "card-header-title"
      content = UI.div # set id_ "main-content" #. "card-content mr-3"

      setTitle = void . (title #) . set text
      setContent = void . (content #) . set children . singleton
      setPage = \case
        GeneralPage -> do
          setTitle "General"
          setContent =<< generalPage
        AudioPage -> do
          setTitle "Audio"
          setContent =<< audioPage
        HotkeyPage -> do
          setTitle "Hotkeys"
          setContent =<< hotkeyPage
        MacroPage -> do
          setTitle "Macros"
          setContent =<< macroPage

  sidebar <- mkSidebar setPage
  setPage GeneralPage

  UI.mkElement "section"
    # set id_ "main-section"
    #. "section columns"
    #+ [ element sidebar,
         UI.mkElement "main"
           #. "column"
           #+ [ UI.div
                  # set id_ "main-card"
                  #. "card"
                  #+ [title, content]
              ]
       ]