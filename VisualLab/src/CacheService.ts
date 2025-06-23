export interface CachedVideoClip { frames: any[]; }

export class CacheService {
  private cache = new Map<string, CachedVideoClip>();

  constructor(private maxEntries = 50) {}

  async cacheClip(id: string, clip: CachedVideoClip): Promise<void> {
    if (this.cache.has(id)) {
      this.cache.delete(id);
    } else if (this.cache.size >= this.maxEntries) {
      const oldest = this.cache.keys().next().value;
      if (oldest) this.cache.delete(oldest);
    }
    this.cache.set(id, clip);
  }

  async loadClip(id: string): Promise<CachedVideoClip | undefined> {
    const clip = this.cache.get(id);
    if (clip) {
      this.cache.delete(id);
      this.cache.set(id, clip);
    }
    return clip;
  }
}
