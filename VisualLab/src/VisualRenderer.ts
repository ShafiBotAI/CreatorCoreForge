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

export class VisualRenderer {
  constructor(private engine = UnifiedVideoEngine.shared) {}

  async render(config: RenderConfig): Promise<VideoClip> {
    const { frames, voiceTrack, ambientTracks = [], style = 'default', resolution = { width: 1280, height: 720 } } = config;
    const clip = await this.engine.render(frames, resolution);
    const audio = [voiceTrack, ...ambientTracks].filter((b): b is Buffer => !!b);
    return {
      frames: clip.frames as Buffer[],
      audio,
      style,
      resolution,
    };
  }
}
