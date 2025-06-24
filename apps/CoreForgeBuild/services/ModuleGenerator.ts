export interface GeneratedModule {
  name: string;
  code: string;
}

import { UIElement } from '../models/UIElement';

/**
 * ModuleGenerator splits a UI layout into small modules.
 * Each top-level element becomes its own module for testing
 * and independent reuse across projects.
 */
export class ModuleGenerator {
  generate(layout: UIElement[]): GeneratedModule[] {
    return layout.map((el, idx) => ({
      name: `Module${idx}`,
      code: JSON.stringify(el)
    }));
  }
}
