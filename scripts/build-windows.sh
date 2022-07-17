#!/bin/bash

cd ..
project_directory=$PWD

# Ask user for root password now, to avoid prompting it multiple times later.
read -p "Enter your root password: " -s rootPassword

# Build the three-penny-gui executable.
nix build .\#x86_64-w64-mingw32:monad-trade:exe:monad-trade

# Ensure npm packages are installed.
npm install

# Prepare three-penny-gui electron dependencies.
parent_build_directory=$project_directory/build
build_directory=$parent_build_directory/windows

echo $rootPassword | sudo -S rm -rf $build_directory # Cleanup past builds.
echo $rootPassword | sudo -S mkdir -p $build_directory
echo $rootPassword | sudo -S cp -a ./result/bin/. $build_directory
echo $rootPassword | sudo -S cp index.js $build_directory/index.js
echo $rootPassword | sudo -S cp tray.png $build_directory/tray.png
echo $rootPassword | sudo -S cp tray@2x.png $build_directory/tray@2x.png
echo $rootPassword | sudo -S cp package.json $build_directory/package.json
echo $rootPassword | sudo -S cp -a ./node_modules $build_directory/node_modules

echo $rootPassword | sudo -S mkdir -p $build_directory/static/css
echo $rootPassword | sudo -S mkdir -p $build_directory/static/webfonts
echo $rootPassword | sudo -S cp -a ./assets/css/. $build_directory/static/css
echo $rootPassword | sudo -S cp -a ./assets/webfonts/. $build_directory/static/webfonts

# Create electron executable.
cd $build_directory
echo $rootPassword | sudo -S $project_directory/node_modules/.bin/electron-packager --platform=win32 --arch=x64 --overwrite --out=$parent_build_directory --icon=$project_directory/favicon.ico .

# Create a zip archive.
cd $parent_build_directory
echo $rootPassword | sudo -S rm -rf monad-trade-win32-x64 # Cleanup past builds.
echo $rootPassword | sudo -S mv "Monad Trade-win32-x64" monad-trade-win32-x64
cd monad-trade-win32-x64
echo $rootPassword | sudo -S chmod 777 . # Allows zip to run without sudo. Zip can't be used via sudo if installed from nix.
zip -r monad-trade-windows.zip .
echo $rootPassword | sudo -S mv monad-trade-windows.zip $parent_build_directory/monad-trade-windows.zip