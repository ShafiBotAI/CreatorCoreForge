export interface RendererOptions {
  width: number;
  height: number;
}

export interface GPUVideoClip {
  frames: any[];
}

export class GPUVideoRenderer {
  async render(
    frames: any[],
    options: RendererOptions
  ): Promise<GPUVideoClip> {
    return { frames };
  }
}
