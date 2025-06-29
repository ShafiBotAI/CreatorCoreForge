import { checkPageAccessibility } from '../services/WCAGChecker';
import puppeteer from 'puppeteer';
import assert from 'node:assert';

(async () => {
  const browser = await puppeteer.launch({
    headless: 'new',
    args: ['--no-sandbox', '--disable-setuid-sandbox']
  });
  const page = await browser.newPage();
  await page.setContent('<html><body><h1>Hello</h1></body></html>');
  const results = await checkPageAccessibility(page);
  assert.ok(results.violations.length >= 0);
  await browser.close();
  console.log('wcag check passed');
})();
