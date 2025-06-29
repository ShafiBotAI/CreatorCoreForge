#!/usr/bin/env node
const { AxePuppeteer } = require('@axe-core/puppeteer');
const puppeteer = require('puppeteer');

(async () => {
  const url = process.argv[2] || 'http://localhost:3000';
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.goto(url);
  const results = await new AxePuppeteer(page).analyze();
  console.log(JSON.stringify(results, null, 2));
  await browser.close();
  if (results.violations.length) {
    process.exitCode = 1;
  }
})();
