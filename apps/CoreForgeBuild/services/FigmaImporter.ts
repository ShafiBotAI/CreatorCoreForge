import { UIElement } from '../models/UIElement';

export class FigmaImporter {
  parse(input: string | Record<string, any>): UIElement[] {
    const obj = typeof input === 'string' ? JSON.parse(input) : input;
    if (!obj) return [];
    const nodes = this.collectNodes(obj);
    return nodes.map(n => ({
      type: (n.type || 'frame').toLowerCase(),
      props: { name: n.name || '' },
      children: n.children ? this.parse(n.children) : undefined
    }));
  }

  private collectNodes(obj: any): any[] {
    if (Array.isArray(obj)) return obj;
    if (obj.nodes) return Array.isArray(obj.nodes) ? obj.nodes : Object.values(obj.nodes);
    if (obj.document && obj.document.children) return obj.document.children;
    if (obj.children) return obj.children;
    return [];
  }
}
