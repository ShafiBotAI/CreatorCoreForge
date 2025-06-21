export interface VideoClip { frames: any[]; }

export class LocalizationService {
  async translateClip(clip: VideoClip, targetLang: string): Promise<VideoClip> {
    return clip;
  }
}
