module Lib where

import Data.Foldable (traverse_)
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
        let styleSheets =
              [ "bulma-0.9.4",
                "fontawesome-6.1.1",
                "sidebar"
              ]
        traverse_ (addStyleSheet window . (<> ".css")) styleSheets
    _ ->
      putStrLn
        [__i|
          This is not a stand-alone executable.
          Please run the bundled electron executable instead. 
        |]