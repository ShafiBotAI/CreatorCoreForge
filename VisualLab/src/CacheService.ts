export interface VideoClip { frames: any[]; }

export class CacheService {
  private cache = new Map<string, VideoClip>();

  async cacheClip(id: string, clip: VideoClip): Promise<void> {
    this.cache.set(id, clip);
  }

  async loadClip(id: string): Promise<VideoClip | undefined> {
    return this.cache.get(id);
  }
}
