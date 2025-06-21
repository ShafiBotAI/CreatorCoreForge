export interface TileStreamClip { frames: any[]; }
export interface Rect { x: number; y: number; width: number; height: number; }

export class TileStreamer {
  async streamTiles(
    clip: TileStreamClip,
    viewport: Rect
  ): Promise<any[]> {
    return clip.frames;
  }
}
