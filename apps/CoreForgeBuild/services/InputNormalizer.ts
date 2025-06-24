import { UIElement } from '../models/UIElement';
import { FigmaImporter } from './FigmaImporter';
import { WireframeParser } from './WireframeParser';
import { PromptParser } from './PromptParser';

/**
 * InputNormalizer converts various inputs like text prompts,
 * design JSON, or image buffers into the shared UIElement
 * representation (ASUIM).
 */
export class InputNormalizer {
  constructor(
    private figma = new FigmaImporter(),
    private wireframe = new WireframeParser(),
    private prompt = new PromptParser()
  ) {}

  toASUIM(input: string | Buffer | Record<string, any>): UIElement[] {
    if (Buffer.isBuffer(input)) {
      return this.wireframe.parse(input);
    }
    if (typeof input === 'string') {
      try {
        const obj = JSON.parse(input);
        if (obj && typeof obj === 'object') {
          return this.figma.parse(obj);
        }
      } catch {
        // treat as plain text prompt
      }
      return this.prompt.parse(input).layout;
    }
    if (typeof input === 'object') {
      return this.figma.parse(input);
    }
    return [];
  }
}
