import { UIElement } from '../models/UIElement';

/**
 * CodeGenService turns a parsed UI layout into source code for various
 * front-end frameworks. This is a minimal proof of concept used for tests.
 */
export type FrontendTarget = 'react' | 'vue' | 'flutter' | 'swiftui' | 'html';
export type BackendTarget = 'express' | 'fastapi' | 'firebase';
export type OutputStyle = 'minimal' | 'intermediate' | 'verbose';

export class CodeGenService {
  generate(
    layout: UIElement[],
    target: FrontendTarget | BackendTarget,
    style: OutputStyle = 'intermediate'
  ): string {
    let code: string;
    switch (target) {
      case 'react':
        code = this.generateReact(layout);
        break;
      case 'vue':
        code = this.generateVue(layout);
        break;
      case 'flutter':
        code = this.generateFlutter(layout);
        break;
      case 'swiftui':
        code = this.generateSwiftUI(layout);
        break;
      case 'express':
        code = this.generateExpress();
        break;
      case 'fastapi':
        code = this.generateFastAPI();
        break;
      case 'firebase':
        code = this.generateFirebase();
        break;
      case 'html':
      default:
        code = this.generateHTML(layout);
    }
    return this.applyStyle(code, style);
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

  /** Placeholder Flutter generator */
  private generateFlutter(layout: UIElement[]): string {
    const body = layout.map((el) => this.elementToFlutter(el, 4)).join(',\n');
    return `// AI-generated Flutter code\nWidget build() {\n  return Column(children:[\n${body}\n  ]);\n}`;
  }

  private elementToFlutter(el: UIElement, indent: number): string {
    const pad = ' '.repeat(indent);
    switch (el.type) {
      case 'header':
        return `${pad}Text('${el.props?.text}', style: TextStyle(fontSize: 24))`;
      case 'paragraph':
        return `${pad}Text('${el.props?.text}')`;
      case 'list':
        const items = el.children?.map((c) => this.elementToFlutter(c, indent + 2)).join(',\n');
        return `${pad}Column(children:[\n${items}\n${pad}])`;
      case 'item':
        return `${pad}Text('${el.props?.text}')`;
      default:
        return `${pad}Container()`;
    }
  }

  private generateSwiftUI(layout: UIElement[]): string {
    const body = layout.map((el) => this.elementToSwiftUI(el, 4)).join('\n');
    return `// AI-generated SwiftUI code\nvar body: some View {\n    VStack {\n${body}\n    }\n}`;
  }

  private elementToSwiftUI(el: UIElement, indent: number): string {
    const pad = ' '.repeat(indent);
    switch (el.type) {
      case 'header':
        return `${pad}Text(\"${el.props?.text}\").font(.title)`;
      case 'paragraph':
        return `${pad}Text(\"${el.props?.text}\")`;
      case 'list':
        const items = el.children?.map((c) => this.elementToSwiftUI(c, indent + 2)).join('\n');
        return `${pad}VStack {\n${items}\n${pad}}`;
      case 'item':
        return `${pad}Text(\"${el.props?.text}\")`;
      default:
        return `${pad}EmptyView()`;
    }
  }

  private generateExpress(): string {
    return `// AI-generated Express backend\nconst express = require('express');\nconst app = express();\napp.get('/', (req, res) => res.send('Hello'));\nmodule.exports = app;`;
  }

  private generateFastAPI(): string {
    return `# AI-generated FastAPI backend\nfrom fastapi import FastAPI\napp = FastAPI()\n@app.get('/')\ndef read_root():\n    return {'Hello': 'World'}`;
  }

  private generateFirebase(): string {
    return `// AI-generated Firebase Functions\nconst functions = require('firebase-functions');\nexports.hello = functions.https.onRequest((req, res) => {\n  res.send('Hello');\n});`;
  }

  private applyStyle(code: string, style: OutputStyle): string {
    if (style === 'minimal') {
      return code.replace(/^\s*\/\/.*$/gm, '').trim();
    }
    if (style === 'verbose') {
      return `// Verbose mode\n${code}`;
    }
    return code;
  }
}
