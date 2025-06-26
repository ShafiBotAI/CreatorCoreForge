const { contextBridge, ipcRenderer } = require('electron');

// Expose a very small API surface to the renderer process. Additional
// channels can be added as needed by the desktop app.
contextBridge.exposeInMainWorld('api', {
  openFileDialog: () => ipcRenderer.invoke('open-file'),
  getAppVersion: () => ipcRenderer.invoke('get-version')
});
