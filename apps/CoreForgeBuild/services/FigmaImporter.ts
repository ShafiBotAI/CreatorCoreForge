import { UIElement } from '../models/UIElement';

export class FigmaImporter {
  parse(input: string | Record<string, any>): UIElement[] {
    const obj = typeof input === 'string' ? JSON.parse(input) : input;
    if (!obj) return [];
    if (obj.layers) {
      return this.parseSketch(obj);
    }
    if (obj.children && obj.children[0] && obj.children[0].type === 'artboard') {
      return this.parseXD(obj);
    }
    const nodes = this.collectNodes(obj);
    return nodes.map((n) => ({
      type: (n.type || 'frame').toLowerCase(),
      props: { name: n.name || '' },
      children: n.children ? this.parse(n.children) : undefined,
    }));
  }

  private parseSketch(obj: any): UIElement[] {
    const layers = Array.isArray(obj.layers) ? obj.layers : [];
    return layers.map((l: any) => ({
      type: (l._class || 'layer').toLowerCase(),
      props: { name: l.name || '' },
      children: l.layers ? this.parseSketch({ layers: l.layers }) : undefined,
    }));
  }

  private parseXD(obj: any): UIElement[] {
    const children = Array.isArray(obj.children) ? obj.children : [];
    return children.map((c: any) => ({
      type: (c.type || 'group').toLowerCase(),
      props: { name: c.name || '' },
      children: c.children ? this.parseXD(c) : undefined,
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
