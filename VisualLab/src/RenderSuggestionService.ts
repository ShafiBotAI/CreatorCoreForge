export class RenderSuggestionService<T> {
  private history: T[] = [];

  recordPath(path: T): void {
    this.history.push(path);
  }

  suggest(nextOptions: T[]): T | undefined {
    const last = this.history[this.history.length - 1];
    if (!last) return nextOptions[0];
    const idx = nextOptions.indexOf(last);
    return nextOptions[idx + 1] || nextOptions[0];
  }
}
