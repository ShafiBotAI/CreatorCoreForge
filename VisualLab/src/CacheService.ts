export interface CachedVideoClip { frames: any[]; }

export class CacheService {
  private cache = new Map<string, CachedVideoClip>();

  async cacheClip(id: string, clip: CachedVideoClip): Promise<void> {
    this.cache.set(id, clip);
  }

  async loadClip(id: string): Promise<CachedVideoClip | undefined> {
    return this.cache.get(id);
  }
}
