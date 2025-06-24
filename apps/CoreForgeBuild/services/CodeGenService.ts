import { UIElement } from '../models/UIElement';

/**
 * CodeGenService turns a parsed UI layout into source code for various
 * front-end frameworks. This is a minimal proof of concept used for tests.
 */
export class CodeGenService {
  generate(layout: UIElement[], target: 'react' | 'vue' | 'flutter' | 'swiftui' | 'html'): string {
    switch (target) {
      case 'react':
        return this.generateReact(layout);
      case 'vue':
        return this.generateVue(layout);
      case 'flutter':
        return this.wrapComment('Flutter code generation not yet implemented');
      case 'swiftui':
        return this.wrapComment('SwiftUI code generation not yet implemented');
      case 'html':
      default:
        return this.generateHTML(layout);
    }
  }

  private wrapComment(text: string): string {
    return `// ${text}`;
  }

  /** Generate React JSX with inline comments summarizing AI logic */
  private generateReact(layout: UIElement[]): string {
    const body = layout.map((el) => this.elementToReact(el, 2)).join('\n');
    return `// AI-generated React code\nexport function App() {\n  return (\n${body}\n  );\n}`;
  }

  private elementToReact(el: UIElement, indent: number): string {
    const pad = ' '.repeat(indent);
    switch (el.type) {
      case 'header':
        return `${pad}<h1>{'${el.props?.text}'}</h1>`;
      case 'paragraph':
        return `${pad}<p>{'${el.props?.text}'}</p>`;
      case 'list':
        const items = el.children?.map((c) => this.elementToReact(c, indent + 2)).join('\n');
        return `${pad}<ul>\n${items}\n${pad}</ul>`;
      case 'item':
        return `${pad}<li>{'${el.props?.text}'}</li>`;
      default:
        return `${pad}<div />`;
    }
  }

  /** Very small Vue generator for demonstration */
  private generateVue(layout: UIElement[]): string {
    const body = layout.map((el) => this.elementToVue(el, 2)).join('\n');
    return `<!-- AI-generated Vue code -->\n<template>\n${body}\n</template>`;
  }

  private elementToVue(el: UIElement, indent: number): string {
    const pad = ' '.repeat(indent);
    switch (el.type) {
      case 'header':
        return `${pad}<h1>{{ '${el.props?.text}' }}</h1>`;
      case 'paragraph':
        return `${pad}<p>{{ '${el.props?.text}' }}</p>`;
      case 'list':
        const items = el.children?.map((c) => this.elementToVue(c, indent + 2)).join('\n');
        return `${pad}<ul>\n${items}\n${pad}</ul>`;
      case 'item':
        return `${pad}<li>{{ '${el.props?.text}' }}</li>`;
      default:
        return `${pad}<div></div>`;
    }
  }

  private generateHTML(layout: UIElement[]): string {
    const body = layout.map((el) => this.elementToHTML(el, 0)).join('\n');
    return `<!-- AI-generated HTML -->\n${body}`;
  }

  private elementToHTML(el: UIElement, indent: number): string {
    const pad = ' '.repeat(indent);
    switch (el.type) {
      case 'header':
        return `${pad}<h1>${el.props?.text}</h1>`;
      case 'paragraph':
        return `${pad}<p>${el.props?.text}</p>`;
      case 'list':
        const items = el.children?.map((c) => this.elementToHTML(c, indent + 2)).join('\n');
        return `${pad}<ul>\n${items}\n${pad}</ul>`;
      case 'item':
        return `${pad}<li>${el.props?.text}</li>`;
      default:
        return `${pad}<div></div>`;
    }
  }
}
