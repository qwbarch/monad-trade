{-# LANGUAGE ScopedTypeVariables #-}

module Lib where

import Data.Functor (void)
import Data.String.Interpolate (i, __i)
import Graphics.UI.Threepenny (Config (..), addStyleSheet, defaultConfig, element, getBody, set, startGUI, string, (#), (#+), (#.))
import qualified Graphics.UI.Threepenny as UI
import System.Environment (getArgs)
import System.IO (BufferMode (..), hSetBuffering, stdout)
import Text.Read (readMaybe)

main :: IO ()
main = do
  hSetBuffering stdout LineBuffering >> fmap (fmap $ readMaybe @Int) getArgs >>= \case
    (Just port) : _ ->
      startGUI defaultConfig {jsPort = Just port, jsStatic = Just "./resources/app/static"} $ \window -> do
        section <- UI.new #. "section" # set UI.class_ "section"

        let header = UI.h1 #+ [string "Hello World!"] # set UI.class_ "title"
            paragraph = UI.p #+ [string "My first website with Bulma!"] # set UI.class_ "subtitle"
            container = UI.div #+ [header, paragraph] # set UI.class_ "container"

        addStyleSheet window "bulma-0.9.4.css"
        addStyleSheet window "fontawesome-6.1.1.css"

        void $ getBody window #+ [element section #+ [container]]
    _ ->
      putStrLn
        [__i|
          This is not a stand-alone executable.
          Please run the bundled electron executable instead. 
        |]