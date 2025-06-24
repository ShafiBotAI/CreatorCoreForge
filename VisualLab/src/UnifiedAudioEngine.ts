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

  /**
   * Gradually adjust volume to a target value.
   * Returns the intermediate levels.
   */
  fadeVolumeTo(target: number, steps = 10): number[] {
    const clamped = Math.min(Math.max(target, 0), 1);
    if (steps <= 0) {
      this.setVolume(clamped);
      return [clamped];
    }
    const start = this.volume;
    const delta = (clamped - start) / steps;
    const levels: number[] = [];
    for (let i = 1; i <= steps; i++) {
      this.setVolume(start + delta * i);
      levels.push(this.currentVolume());
    }
    return levels;
  }
}

