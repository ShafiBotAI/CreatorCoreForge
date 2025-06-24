import { ParseResult } from './PromptParser';

export interface HistoryEntry {
  prompt: string;
  result?: ParseResult;
  timestamp: number;
}

/**
 * InputHistory stores raw prompts or UI descriptions so that
 * the system can analyze how instructions evolve over time.
 */
export class InputHistory {
  private history: HistoryEntry[] = [];

  add(prompt: string, result?: ParseResult): void {
    this.history.push({ prompt, result, timestamp: Date.now() });
  }

  list(): HistoryEntry[] {
    return [...this.history];
  }
}
