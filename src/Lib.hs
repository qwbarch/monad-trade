module Lib where

import Data.Functor (void)
import Data.String.Interpolate (__i)
import Graphics.UI.Threepenny (Config (..), defaultConfig, set, startGUI, title, (#))
import System.Environment (getArgs)
import System.IO (BufferMode (..), hSetBuffering, stdout)
import Text.Read (readMaybe)

main :: IO ()
main = do
  hSetBuffering stdout LineBuffering >> fmap (fmap $ readMaybe @Int) getArgs >>= \case
    (Just port) : _ ->
      startGUI defaultConfig {jsPort = Just port} $ \window -> do
        void $ pure window # set title "Monad Trade"
    _ ->
      putStrLn
        [__i|
          This is not a stand-alone executable.
          Please run the bundled electron executable instead. 
        |]