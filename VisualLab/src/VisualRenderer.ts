export interface RenderConfig {
  frames: Buffer[];
  voiceTrack?: Buffer;
  ambientTracks?: Buffer[];
  style?: string;
  resolution?: { width: number; height: number };
}

export interface VideoClip {
  frames: Buffer[];
  audio: Buffer[];
  style: string;
  resolution: { width: number; height: number };
}

import { UnifiedVideoEngine } from './UnifiedVideoEngine.ts';
import { censorLayer } from './CensorService.ts';

export class VisualRenderer {
  constructor(private engine = UnifiedVideoEngine.shared) {}

  async render(config: RenderConfig): Promise<VideoClip> {
    const { frames, voiceTrack, ambientTracks = [], style = 'default', resolution = { width: 1280, height: 720 } } = config;
    const clip = await this.engine.render(frames, resolution);
    const processedFrames = (clip.frames as any).map((f: any) => f.frame ?? f) as Buffer[];
    const audio = [voiceTrack, ...ambientTracks].filter((b): b is Buffer => !!b);
    return {
      frames: processedFrames,
      audio,
      style,
      resolution,
    };
  }

  /**
   * Render both an NSFW version and a safe version of a scene. The safe
   * version uses basic censoring based on the provided level.
   */
  async renderDual(
    config: RenderConfig & { censorLevel?: number }
  ): Promise<{ nsfw: VideoClip; safe: VideoClip }> {
    const nsfw = await this.render(config);
    const level = config.censorLevel ?? 1;
    const safeFrames = config.frames.map((f) =>
      Buffer.from(censorLayer(f.toString(), level))
    );
    const safe = await this.render({ ...config, frames: safeFrames });
    return { nsfw, safe };
  }
}
