import { UIElement } from '../models/UIElement';

/**
 * WireframeParser converts a very basic image buffer
 * into a minimal UI layout. This is a naive placeholder
 * that estimates size based on the buffer length.
 */
export class WireframeParser {
  parse(data: Buffer): UIElement[] {
    const dimension = Math.max(1, Math.round(Math.sqrt(data.length)));
    return [
      {
        type: 'container',
        props: { width: dimension, height: dimension, bytes: data.length }
      }
    ];
  }
}
