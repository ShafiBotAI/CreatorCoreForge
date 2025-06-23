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
    // Attach target resolution metadata to each frame for testing purposes.
    const processed = frames.map(f => ({ frame: f, size: [options.width, options.height] }));
    return { frames: processed };
  }
}
