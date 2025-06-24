import { UIElement } from '../models/UIElement';

export interface Correction {
  index: number;
  text: string;
}

/**
 * PromptEditor applies simple corrections to an existing UI layout.
 */
export class PromptEditor {
  applyCorrection(layout: UIElement[], correction: Correction): UIElement[] {
    if (layout[correction.index]) {
      layout[correction.index].props = {
        ...(layout[correction.index].props || {}),
        text: correction.text,
        ariaLabel: correction.text
      };
    }
    return layout;
  }
}
