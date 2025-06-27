import { UIElement } from '../models/UIElement';

/**
 * WireframeParser converts an image buffer into a minimal
 * UI layout description.  When the buffer represents a PNG
 * image, the actual pixel dimensions are extracted.  For
 * all other data the parser falls back to a simple heuristic
 * based on the buffer size so the method always returns a
 * reasonable layout element.
 */
export class WireframeParser {
  private parsePngDimensions(data: Buffer): { width: number; height: number } | null {
    const signature = '89504e470d0a1a0a';
    if (data.slice(0, 8).toString('hex') !== signature) return null;
    const idx = data.indexOf('IHDR');
    if (idx === -1 || idx + 8 >= data.length) return null;
    const width = data.readUInt32BE(idx + 4);
    const height = data.readUInt32BE(idx + 8);
    return { width, height };
  }

  parse(data: Buffer): UIElement[] {
    const dims = this.parsePngDimensions(data);
    const width = dims ? dims.width : Math.max(1, Math.round(Math.sqrt(data.length)));
    const height = dims ? dims.height : width;

    return [
      {
        type: 'container',
        props: { width, height, bytes: data.length, orientation: width >= height ? 'landscape' : 'portrait' }
      }
    ];
  }
}
