export interface CachedVideoClip { frames: any[]; }

/**
 * Generic LRU cache for video clips with optional time-to-live.
 */
export class CacheService<T extends CachedVideoClip = CachedVideoClip> {
  private cache = new Map<string, { clip: T; ts: number }>();

  constructor(private maxEntries = 50, private ttlMs = 5 * 60_000) {}

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
    const entry = this.cache.get(id);
    if (!entry) return undefined;
    if (Date.now() - entry.ts > this.ttlMs) {
      this.cache.delete(id);
      return undefined;
    }
    this.cache.delete(id);
    this.cache.set(id, { ...entry, ts: Date.now() });
    return entry.clip;
  }
}
