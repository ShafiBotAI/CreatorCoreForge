import { UIElement } from '../models/UIElement';

export interface VersionEntry {
  timestamp: number;
  prompt: string;
  layout: UIElement[];
}

export class VersionHistory {
  private history: VersionEntry[] = [];

  add(entry: VersionEntry) {
    this.history.push(entry);
  }

  latest(): VersionEntry | null {
    return this.history[this.history.length - 1] || null;
  }

  all(): VersionEntry[] {
    return [...this.history];
  }
}
