#!/usr/bin/env node
import { exec } from 'child_process';
import { resolve } from 'path';

const file = resolve(__dirname, '../Desktop/index.html');
const openCmd = process.platform === 'win32' ? 'start' : process.platform === 'darwin' ? 'open' : 'xdg-open';

exec(`${openCmd} ${file}`, err => {
  if (err) console.error(err);
});
