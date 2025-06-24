export interface UploadResult { success: boolean; log: string; }

export class UploadManager {
  private logs: string[] = [];
  private maxPlatforms = 1;

  enableSecondPlatform(): void {
    this.maxPlatforms = 2;
  }

  async upload(video: Buffer, platforms: string[]): Promise<UploadResult> {
    const allowed = platforms.slice(0, this.maxPlatforms);
    const log = `upload:${allowed.join(',')}`;
    this.logs.push(log);
    return { success: true, log };
  }

  getLogs(): string[] {
    return this.logs;
  }
}
