/**
 * This file is taken from https://github.com/HeinrichApfelmus/threepenny-gui/blob/master/doc/electron.md
 */

const argv = process.argv

const { app, BrowserWindow, Tray, Menu } = require('electron');
const freeport = require('freeport');
const spawn = require('child_process').spawn;
const path = require('path');
const waitOn = require('wait-on');

const timeout = 10000;

let relBin = "monad-trade"
if (process.platform === "win32")
  relBin += ".exe"
else if (process.platform !== "linux")
  throw new Error("This operating system is not supported.")

freeport((err, port) => {
  if (err) throw err;

  const url = `http://localhost:${port}`;
  let child = null;
  let window;
  let tray;
  let isQuitting = false;

  function createWindow() {
    tray = new Tray(path.join(__dirname, "tray.png"));
    tray.setContextMenu(Menu.buildFromTemplate([
      {
        label: "Options",
        click: () => window.show()
      },
      {
        label: "Quit",
        click: () => {
          isQuitting = true;
          app.quit();
        }
      }
    ]))

    window = new BrowserWindow({
      title: "Monad Trade",
      width: 800,
      height: 600,
      show: false,
      webPreferences: { nodeIntegration: true },
    });
    window.removeMenu(true);

    console.log(`Loading URL: ${url}`);
    window.loadURL(url);

    window.on("minimize", event => {
      event.preventDefault();
      window.hide();
    });

    // BrowserWindow's closable attribute isn't implemented in Linux, so we'll have it minimize to tray instead.
    window.on("close", event => {
      if (!isQuitting) {
        event.preventDefault();
        window.hide();
        event.returnValue = false;
      }
    })

    window.on('closed', event => {
      window = null;
      tray = null;
    });
  };

  app.on("before-quit", () => {
    isQuitting = true;
  });

  app.on('ready', () => {
    child = spawn(path.join(__dirname, relBin), [port]);
    child.stdout.setEncoding('utf8');
    child.stderr.setEncoding('utf8');
    child.stdout.on('data', console.log);
    child.stderr.on('data', console.log);
    child.on('close', code => console.log(`Threepenny app exited with code ${code}`));

    waitOn({ resources: [url], timeout }, (err_) => {
      if (err_) throw err_;
      createWindow();
    });
  });

  app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') {
      app.quit();
    }
  });

  app.on('will-quit', () => child.kill());

  app.on('activate', () => {
    if (window === null) {
      createWindow();
    }
  });
});