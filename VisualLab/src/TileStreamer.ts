export interface VideoClip { frames: any[]; }
export interface Rect { x: number; y: number; width: number; height: number; }

export class TileStreamer {
  async streamTiles(clip: VideoClip, viewport: Rect): Promise<any[]> {
    return clip.frames;
  }
}
