import { GPUVideoRenderer, RendererOptions, GPUVideoClip } from './GPUVideoRenderer.ts';

export class UnifiedVideoEngine {
  static shared = new UnifiedVideoEngine();
  private constructor(private renderer = new GPUVideoRenderer()) {}

  async render(frames: any[], options: RendererOptions): Promise<GPUVideoClip> {
    return this.renderer.render(frames, options);
  }
}
