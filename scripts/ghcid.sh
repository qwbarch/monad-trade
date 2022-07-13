#!/bin/bash
cd ..
nix develop --command ghcid --command "cabal repl src/Lib.hs" --test :main -W