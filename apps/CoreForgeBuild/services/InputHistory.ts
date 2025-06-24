export interface HistoryEntry {
  prompt: string;
  timestamp: number;
}

/**
 * InputHistory stores raw prompts or UI descriptions so that
 * the system can analyze how instructions evolve over time.
 */
export class InputHistory {
  private history: HistoryEntry[] = [];

  add(prompt: string): void {
    this.history.push({ prompt, timestamp: Date.now() });
  }

  list(): HistoryEntry[] {
    return [...this.history];
  }
}
