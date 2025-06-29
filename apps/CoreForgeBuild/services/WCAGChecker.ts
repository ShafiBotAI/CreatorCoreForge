import axe from 'axe-core';
import { AxePuppeteer } from '@axe-core/puppeteer';
import type { Page } from 'puppeteer';

export async function checkAccessibility(node: HTMLElement): Promise<axe.AxeResults> {
  return await axe.run(node);
}

export async function checkPageAccessibility(page: Page): Promise<axe.AxeResults> {
  return await new AxePuppeteer(page).analyze();
}
