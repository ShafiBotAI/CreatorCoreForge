export interface DRMConfig { watermark: string; }
export interface DRMVideoClip { frames: any[]; }

export class DRMService {
  async embedWatermark(
    video: DRMVideoClip,
    config: DRMConfig
  ): Promise<DRMVideoClip> {
    return video;
  }
}
