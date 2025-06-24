import { UIElement } from '../models/UIElement';

export interface ParseResult {
  language: string;
  layout: UIElement[];
}

/**
 * PromptParser handles multilingual prompt strings and converts a very small
 * subset of markdown-like syntax into an abstract syntax UI model (ASUIM).
 */
export class PromptParser {
  private languages: Record<string, RegExp> = {
    en: /[a-zA-Z]/,
    es: /[\u00C0-\u017F]/,
    zh: /[\u4e00-\u9fa5]/,
  };

  parse(prompt: string): ParseResult {
    const language = this.detectLanguage(prompt);
    const normalized = this.normalize(prompt);
    const layout = this.parseMarkdown(normalized);
    return { language, layout };
  }

  /**
   * Very naive language detection. Defaults to 'en'.
   */
  private detectLanguage(text: string): string {
    for (const [lang, regex] of Object.entries(this.languages)) {
      if (regex.test(text)) {
        return lang;
      }
    }
    return 'en';
  }

  /**
   * Normalize common malformed inputs by trimming whitespace and replacing
   * repeated spaces.
   */
  private normalize(text: string): string {
    const normalizedNewlines = text.replace(/\r?\n/g, '\n');
    return normalizedNewlines
      .split('\n')
      .map((line) => line.replace(/\s+/g, ' ').trimEnd())
      .join('\n')
      .trim();
  }

  /**
   * Parse a minimal markdown-like layout into a tree of UIElements.
   * Supported syntax:
   * - Lines starting with '# ' -> header
   * - '- ' -> list item inside a container
   * Anything else becomes a paragraph.
   */
  private parseMarkdown(text: string): UIElement[] {
    const lines = text.split(/\n+/);
    const result: UIElement[] = [];
    let currentList: UIElement | null = null;

    for (const line of lines) {
      if (line.startsWith('# ')) {
        result.push({ type: 'header', props: { text: line.slice(2) } });
        currentList = null;
      } else if (line.startsWith('- ')) {
        if (!currentList) {
          currentList = { type: 'list', children: [] };
          result.push(currentList);
        }
        currentList.children!.push({ type: 'item', props: { text: line.slice(2) } });
      } else if (line.trim()) {
        result.push({ type: 'paragraph', props: { text: line.trim() } });
        currentList = null;
      }
    }
    return result;
  }
}
