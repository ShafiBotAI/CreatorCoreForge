import axe from 'axe-core';

export async function checkAccessibility(node: HTMLElement): Promise<axe.AxeResults> {
  return await axe.run(node);
}
