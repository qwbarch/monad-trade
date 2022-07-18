module Interface where

import Graphics.UI.Threepenny (Element, UI, id_, set, text, (#), (#+), (#.))
import qualified Graphics.UI.Threepenny as UI
import Interface.Sidebar (sidebar)

interface :: UI Element
interface = section #+ [sidebar, container]
  where
    section =
      UI.mkElement "section"
        # set id_ "main-section"
        #. "section columns"
    container = UI.mkElement "main" #. "column" #+ [card]
    card = UI.div # set id_ "main-card" #. "card" #+ [title, content]
    title =
      UI.div
        #. "card-header"
        #+ [UI.p # set id_ "main-title" #. "card-header-title" # set text "Audio"]
    content = UI.div # set id_ "main-content" #. "card-content mr-3"