const fs = require('fs');
const path = require('path');

const SRC = path.join('locales', 'en.json');
const OUT_DIR = path.join('generated', 'pseudo_locales');

function pseudo(text) {
  return text
    .replace(/[a-zA-Z]/g, c => String.fromCharCode(c.charCodeAt(0) + 0x0450))
    .replace(/\./g, '•');
}

if (!fs.existsSync(SRC)) {
  console.error('Missing default localization file');
  process.exit(1);
}
const en = JSON.parse(fs.readFileSync(SRC, 'utf8'));
const pseudoLocale = {};
for (const [k, v] of Object.entries(en)) {
  pseudoLocale[k] = pseudo(String(v));
}
fs.mkdirSync(OUT_DIR, { recursive: true });
fs.writeFileSync(path.join(OUT_DIR, 'pseudo.json'), JSON.stringify(pseudoLocale, null, 2));
console.log('Pseudo-localization written to', OUT_DIR);
