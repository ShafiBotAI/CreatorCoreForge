export class UnifiedAudioEngine {
  private volume = 1;
  private muted = false;
  static shared = new UnifiedAudioEngine();

  private constructor() {}

  setVolume(value: number): void {
    this.volume = Math.min(Math.max(value, 0), 1);
  }

  currentVolume(): number {
    return this.volume;
  }

  mute(): void {
    this.muted = true;
  }

  unmute(): void {
    this.muted = false;
  }

  isMuted(): boolean {
    return this.muted;
  }
}

