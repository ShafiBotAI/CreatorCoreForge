export interface RenderOptions {
  width: number;
  height: number;
}

export interface VideoClip {
  frames: any[];
}

export class GPUVideoRenderer {
  async render(frames: any[], options: RenderOptions): Promise<VideoClip> {
    return { frames };
  }
}
