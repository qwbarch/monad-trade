module Lib where

import Data.Functor (void)
import Data.String.Interpolate (__i)
import Graphics.UI.Threepenny (Config (..), addStyleSheet, defaultConfig, element, getBody, set, startGUI, string, title, (#), (#+), (#.))
import qualified Graphics.UI.Threepenny as UI
import System.Environment (getArgs)
import System.IO (BufferMode (..), hSetBuffering, stdout)
import Text.Read (readMaybe)

main :: IO ()
main = do
  hSetBuffering stdout LineBuffering >> fmap (fmap $ readMaybe @Int) getArgs >>= \case
    (Just port) : _ ->
      startGUI defaultConfig {jsPort = Just port, jsStatic = Just "./resources/app"} $ \window -> do
        addStyleSheet window "bulma.css"
        section <- UI.new #. "section" # set UI.class_ "section"

        let header = UI.h1 #+ [string "Hello World!"] # set UI.class_ "title"
            paragraph = UI.p #+ [string "My first website with Bulma!"] # set UI.class_ "subtitle"
            container = UI.div #+ [header, paragraph] # set UI.class_ "container"

        void $ getBody window #+ [element section #+ [container]]
    _ ->
      putStrLn
        [__i|
          This is not a stand-alone executable.
          Please run the bundled electron executable instead. 
        |]