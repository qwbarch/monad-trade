#!/bin/bash

cd ..
project_directory=$PWD

# Ask user for root password now, to avoid prompting it multiple times later.
read -p "Enter your root password: " -s rootPassword

# Prepare npm packages.
npm install

# Build the three-penny-gui executable.
echo $rootPassword | sudo -S rm -rf ./result/bin
nix build

# Prepare three-penny-gui electron dependencies.
echo $rootPassword | sudo -S cp -r node_modules ./result/bin/node_modules
echo $rootPassword | sudo -S cp package.json ./result/bin/package.json
echo $rootPassword | sudo -S cp index.js ./result/bin/index.js
echo $rootPassword | sudo -S cp tray.png ./result/bin/tray.png
echo $rootPassword | sudo -S mkdir -p ./result/bin/css
echo $rootPassword | sudo -S cp node_modules/bulma/css/bulma.min.css ./result/bin/css/bulma.css

# Create electron executable and archive it.
cd ./result/bin # This is required to make electron-packager not bundle in our source files.
echo $rootPassword | sudo -S $project_directory/node_modules/.bin/electron-packager --platform=linux --arch=x64 --overwrite --out=$project_directory/build --icon=$project_directory/logo-512x512.png .
cd $project_directory/build
echo $rootPassword | sudo -S chmod 777 .
echo $rootPassword | sudo -S rm -rf ./monad-trade-linux-x64
echo $rootPassword | sudo -S mv ./"Monad Trade-linux-x64" ./monad-trade-linux-x64
echo $rootPassword | sudo -S mv ./monad-trade-linux-x64/"Monad Trade" ./monad-trade-linux-x64/monad-trade
tar -czvf monad-trade-linux.tar.gz -C ./monad-trade-linux-x64 .
