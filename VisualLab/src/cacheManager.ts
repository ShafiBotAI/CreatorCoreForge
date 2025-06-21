export class CacheManager<T> {
  private cache = new Map<string, T>();
  constructor(private limit = 10) {}

  get(key: string): T | undefined {
    return this.cache.get(key);
  }

  set(key: string, value: T): void {
    this.cache.set(key, value);
    if (this.cache.size > this.limit) {
      const first = this.cache.keys().next();
      if (!first.done) {
        this.cache.delete(first.value);
      }
    }
  }
}
