import {
  GPUVideoRenderer,
  RendererOptions,
  GPUVideoClip,
  RenderedFrame,
} from './GPUVideoRenderer.ts';

export class UnifiedVideoEngine<F = unknown> {
  static shared = new UnifiedVideoEngine();
  private constructor(private renderer = new GPUVideoRenderer<F>()) {}

  async render(
    frames: F[],
    options: RendererOptions
  ): Promise<GPUVideoClip<RenderedFrame<F>>> {
    return this.renderer.render(frames, options);
  }
}
