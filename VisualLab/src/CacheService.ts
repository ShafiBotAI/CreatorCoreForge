export interface CachedVideoClip { frames: any[]; }

/**
 * Generic LRU cache for video clips with optional time-to-live.
 */
export class CacheService<T extends CachedVideoClip = CachedVideoClip> {
  private cache = new Map<string, { clip: T; ts: number }>();

  // Increased default max entries and TTL for smoother performance in longer sessions
  constructor(private maxEntries = 100, private ttlMs = 10 * 60_000) {}

  async cacheClip(id: string, clip: T): Promise<void> {
    const now = Date.now();
    this.cache.delete(id);
    this.cache.set(id, { clip, ts: now });
    this.evict(now);
  }

  private evict(now: number) {
    while (this.cache.size > this.maxEntries) {
      const oldest = this.cache.keys().next().value;
      this.cache.delete(oldest);
    }
    for (const [key, value] of this.cache) {
      if (now - value.ts > this.ttlMs) this.cache.delete(key);
    }
  }

  async loadClip(id: string): Promise<T | undefined> {
    this.evict(Date.now());
    const entry = this.cache.get(id);
    if (!entry) return undefined;
    this.cache.delete(id);
    this.cache.set(id, { ...entry, ts: Date.now() });
    return entry.clip;
  }

  currentSize(): number {
    this.evict(Date.now());
    return this.cache.size;
  }
}
