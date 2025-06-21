export interface DRMConfig { watermark: string; }
export interface VideoClip { frames: any[]; }

export class DRMService {
  async embedWatermark(video: VideoClip, config: DRMConfig): Promise<VideoClip> {
    return video;
  }
}
