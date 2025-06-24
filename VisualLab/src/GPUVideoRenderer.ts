export interface RendererOptions {
  width: number;
  height: number;
}

export interface RenderedFrame<F> {
  frame: F;
  size: [number, number];
}

export interface GPUVideoClip<F = RenderedFrame<unknown>> {
  frames: F[];
}

export class GPUVideoRenderer<F = unknown> {
  async render(
    frames: F[],
    options: RendererOptions
  ): Promise<GPUVideoClip<RenderedFrame<F>>> {
    const processed = frames.map(frame => ({ frame, size: [options.width, options.height] }));
    return { frames: processed };
  }
}
