export interface VideoOverlay { frames: any[]; }

export class SignLanguageService {
  async generateOverlay(audio: Blob): Promise<VideoOverlay> {
    return { frames: [] };
  }
}
