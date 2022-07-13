#!/bin/bash

cd ..
project_directory=$PWD

# Ask user for root password now, to avoid prompting it multiple times later.
read -p "Enter your root password: " -s rootPassword

# Prepare npm packages.
npm install

# Build the three-penny-gui executable.
nix build .\#x86_64-w64-mingw32:monad-trade:exe:monad-trade

# Prepare three-penny-gui electron dependencies.
echo $rootPassword | sudo -S cp -r node_modules ./result/bin/node_modules
echo $rootPassword | sudo -S cp package.json ./result/bin/package.json
echo $rootPassword | sudo -S cp index.js ./result/bin/index.js
echo $rootPassword | sudo -S cp tray.png ./result/bin/tray.png

# Create electron executable and archive it.
cd ./result/bin # This is required to make electron-packager not bundle in our source files.
echo $rootPassword | sudo -S $project_directory/node_modules/.bin/electron-packager --platform=win32 --arch=x64 --overwrite --out=$project_directory/build --icon=$project_directory/favicon.ico .
cd $project_directory/build
echo $rootPassword | sudo -S chmod 777 .
echo $rootPassword | sudo -S rm -rf ./monad-trade-win32-x64
echo $rootPassword | sudo -S mv ./"Monad Trade-win32-x64" ./monad-trade-win32-x64
cd ./monad-trade-win32-x64
echo $rootPassword | sudo -S chmod 777 .
zip -r monad-trade-windows.zip .
mv monad-trade-windows.zip ../monad-trade-windows.zip