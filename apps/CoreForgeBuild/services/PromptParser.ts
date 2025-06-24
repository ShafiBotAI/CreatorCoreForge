import { UIElement } from '../models/UIElement';

export interface ParseResult {
  language: string;
  layout: UIElement[];
  flows: string[][];
  /**
   * Unique flow step tags extracted from the prompt. These can be
   * used for quick logic inference without inspecting the raw flows.
   */
  flowTags: string[];
  /**
   * Recognized UX patterns like onboarding or tabbed navigation.
   */
  patterns?: string[];
  /**
   * Optional conditional flow chains detected in the prompt.
   */
  conditionals?: string[][];
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
    fr: /[\u00C0-\u017F]/,
    de: /[\u00C0-\u017F]/
  };

  private translations: Record<string, Record<string, string>> = {
    es: { hola: 'hello', inicio: 'login' },
    zh: { "\u4f60\u597d": 'hello' },
    fr: { bonjour: 'hello' },
    de: { hallo: 'hello' }
  };

  parse(prompt: string): ParseResult {
    const language = this.detectLanguage(prompt);
    const translated = language !== 'en' ? this.translateToEnglish(prompt, language) : prompt;
    const normalized = this.normalize(translated);
    const layout = /[#\-]/.test(normalized)
      ? this.parseMarkdown(normalized)
      : this.parseNaturalLanguage(normalized);
    const flows = this.parseFlows(normalized);
    const flowTags = Array.from(new Set(flows.flat()));
    const patterns = this.recognizePatterns(normalized);
    const conditionals = this.parseConditionals(normalized);
    return { language, layout, flows, flowTags, patterns, conditionals };
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

  private translateToEnglish(text: string, lang: string): string {
    const dict = this.translations[lang] || {};
    return text
      .split(/\s+/)
      .map((w) => dict[w.toLowerCase()] || w)
      .join(' ');
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

  private recognizePatterns(text: string): string[] {
    const lower = text.toLowerCase();
    const patterns: string[] = [];
    if (lower.includes('onboarding') || lower.includes('sign up')) {
      patterns.push('onboarding');
    }
    if (lower.includes('tabbed')) {
      patterns.push('tabbed-navigation');
    }
    if (lower.includes('floating action')) {
      patterns.push('floating-action-button');
    }
    return patterns;
  }

  private parseConditionals(text: string): string[][] {
    const matches = text.match(/if[^\n]+/gi) || [];
    return matches.map((m) =>
      m
        .replace(/if\s*/i, '')
        .split(/->/)
        .map((s) => s.trim())
        .filter(Boolean)
    );
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
        const textContent = line.slice(2);
        result.push({ type: 'header', props: { text: textContent, ariaLabel: textContent } });
        currentList = null;
      } else if (line.startsWith('- ')) {
        if (!currentList) {
          currentList = { type: 'list', children: [] };
          result.push(currentList);
        }
        const itemText = line.slice(2);
        currentList.children!.push({ type: 'item', props: { text: itemText, ariaLabel: itemText } });
      } else if (line.trim()) {
        const p = line.trim();
        result.push({ type: 'paragraph', props: { text: p, ariaLabel: p } });
        currentList = null;
      }
    }
    return result;
  }

  /**
   * Very naive natural language parser that looks for common
   * UI keywords like "login" or "dashboard" and builds a
   * minimal layout from the description.
   */
  private parseNaturalLanguage(text: string): UIElement[] {
    const lower = text.toLowerCase();
    const layout: UIElement[] = [];
    if (lower.includes('login')) {
      layout.push({ type: 'header', props: { text: 'Login', ariaLabel: 'Login' } });
      if (lower.includes('email')) {
        layout.push({ type: 'paragraph', props: { text: 'Email field', ariaLabel: 'Email field' } });
      }
      if (lower.includes('password')) {
        layout.push({ type: 'paragraph', props: { text: 'Password field', ariaLabel: 'Password field' } });
      }
    }
    if (layout.length === 0) {
      layout.push({ type: 'paragraph', props: { text, ariaLabel: text } });
    }
    return layout;
  }

  /**
   * Parse simple user flow descriptions like
   * "login -> dashboard -> settings" into arrays
   * of step names.
   */
  private parseFlows(text: string): string[][] {
    const flows: string[][] = [];
    const lines = text.split(/\n+/);
    for (const line of lines) {
      if (line.includes('->')) {
        const steps = line
          .split(/->/)
          .map((s) => s.trim())
          .filter(Boolean);
        if (steps.length > 1) {
          flows.push(steps);
        }
      } else if (/if\s+/i.test(line)) {
        const parts = line
          .replace(/if\s*/i, '')
          .split(/->/)
          .map((p) => p.trim())
          .filter(Boolean);
        if (parts.length > 1) {
          flows.push(parts);
        }
      }
    }
    return flows;
  }
}
