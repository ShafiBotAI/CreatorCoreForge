export interface RendererOptions {
  width: number;
  height: number;
}

export interface GPUVideoClip {
  frames: any[];
}

export class UnifiedVideoEngine {
  static shared = new UnifiedVideoEngine();
  private constructor() {}

  async render(frames: any[], options: RendererOptions): Promise<GPUVideoClip> {
    return { frames };
  }
}
