import { UIElement } from '../models/UIElement';

/**
 * LogicVisualizer renders a simple ASCII tree of the parsed
 * UI layout. It is used in tests to preview the layout prior
 * to code generation.
 */
export class LogicVisualizer {
  toASCII(layout: UIElement[], indent = 0): string {
    return layout
      .map(el => {
        const pad = ' '.repeat(indent);
        const children = el.children ? '\n' + this.toASCII(el.children, indent + 2) : '';
        return `${pad}${el.type}${children}`;
      })
      .join('\n');
  }
}
