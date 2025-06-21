const { app, BrowserWindow } = require('electron');
const { generateText, synthesizeSpeech } = require('../../scripts/ai');

function createWindow() {
  const win = new BrowserWindow({ width: 800, height: 600 });
  win.loadFile('index.html');
}

async function demo() {
  try {
    const text = await generateText('Hello from CoreForgeDNA');
    console.log('OpenAI:', text);
    const audio = await synthesizeSpeech(text, '21m00Tcm4TlvDq8ikWAM');
    console.log('ElevenLabs bytes:', audio.length);
  } catch (err) {
    console.error('AI error:', err.message);
  }
}

app.whenReady().then(() => {
  createWindow();
  demo();
});
