export class UnifiedAudioEngine {
  private volume = 1;
  private muted = false;
  static shared = new UnifiedAudioEngine();

  private constructor() {}

  setVolume(value: number) {
    this.volume = Math.min(Math.max(value, 0), 1);
  }

  currentVolume(): number {
    return this.volume;
  }

  mute() {
    this.muted = true;
  }

  unmute() {
    this.muted = false;
  }

  isMuted(): boolean {
    return this.muted;
  }
}

