export interface LocalizationClip { frames: any[]; }

export class LocalizationService {
  async translateClip(
    clip: LocalizationClip,
    targetLang: string
  ): Promise<LocalizationClip> {
    return clip;
  }
}
