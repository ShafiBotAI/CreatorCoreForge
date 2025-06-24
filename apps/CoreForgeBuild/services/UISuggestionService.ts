import { UIElement } from '../models/UIElement';

/**
 * UISuggestionService provides very lightweight AI-style
 * suggestions for the next UI elements a creator might add
 * based on the current layout state.
 */
export class UISuggestionService {
  suggestNext(layout: UIElement[]): string[] {
    if (layout.length === 0) {
      return ['header', 'paragraph'];
    }
    const last = layout[layout.length - 1];
    if (last.type === 'header') {
      const text = (last.props?.text || '').toLowerCase();
      if (text.includes('login')) {
        return ['text-input-email', 'text-input-password', 'button'];
      }
      if (text.includes('dashboard')) {
        return ['chart', 'navigation', 'list'];
      }
    }
    return ['paragraph'];
  }

  /**
   * Suggest common UI building blocks based on the overall
   * application type. This helps creators scaffold layouts
   * before dropping specific components.
   */
  suggestPatterns(appType: string): string[] {
    const type = appType.toLowerCase();
    if (type.includes('chat')) {
      return ['message-list', 'input-box', 'send-button'];
    }
    if (type.includes('dashboard')) {
      return ['sidebar', 'stats-grid', 'chart'];
    }
    if (type.includes('calculator')) {
      return ['display', 'button-grid'];
    }
    return ['header', 'content', 'footer'];
  }
}
