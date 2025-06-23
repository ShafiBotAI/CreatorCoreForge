export interface AudioChain {
  name: string;
  effects: string[];
}

export class AudioEffectService {
  private presets: Record<string, string[]> = {
    warm: ['eq-low-shelf:+3dB', 'compressor:light'],
    broadcast: ['compressor:heavy', 'limiter'],
  };

  /**
   * Load a preset and return its effect chain. Unknown presets
   * fall back to an empty chain.
   */
  loadPreset(presetName: string): AudioChain {
    return {
      name: presetName,
      effects: this.presets[presetName] ?? [],
    };
  }
}
