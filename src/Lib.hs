module Lib where

import Data.Foldable (traverse_)
import Data.Functor (void)
import Data.String.Interpolate (__i)
import Graphics.UI.Threepenny (Config (..), addStyleSheet, defaultConfig, getBody, id_, set, startGUI, text, (#), (#+), (#.))
import qualified Graphics.UI.Threepenny as UI
import Interface.Sidebar (sidebar)
import System.Environment (getArgs)
import System.IO (BufferMode (..), hSetBuffering, stdout)
import Text.Read (readMaybe)

main :: IO ()
main = do
  hSetBuffering stdout LineBuffering >> fmap (fmap $ readMaybe @Int) getArgs >>= \case
    (Just port) : _ ->
      startGUI defaultConfig {jsPort = Just port, jsStatic = Just "./resources/app/static"} $ \window -> do
        let styleSheets =
              [ "bulma-0.9.4",
                "fontawesome-6.1.1",
                "main",
                "sidebar"
              ]
            section =
              UI.mkElement "section"
                # set id_ "main-section"
                #. "section columns"
            container = UI.mkElement "main" #. "column" #+ [card]
            card = UI.div # set id_ "main-card" #. "card" #+ [title, content]
            title =
              UI.div
                #. "card-header"
                #+ [UI.p #. "card-header-title title" # set text "Audio"]
            content = UI.div # set id_ "main-content" #. "card-content mr-3"
        traverse_ (addStyleSheet window . (<> ".css")) styleSheets
        void $ getBody window #+ [section #+ [sidebar, container]]
    _ ->
      putStrLn
        [__i|
          This is not a stand-alone executable.
          Please run the bundled electron executable instead. 
        |]