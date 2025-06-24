import { ParseResult } from './PromptParser';

/**
 * ParseHistory keeps track of parse results for rollback.
 */
export class ParseHistory {
  private history: ParseResult[] = [];

  add(result: ParseResult): void {
    this.history.push(result);
  }

  all(): ParseResult[] {
    return [...this.history];
  }

  rollback(): ParseResult | null {
    return this.history.pop() || null;
  }
}
