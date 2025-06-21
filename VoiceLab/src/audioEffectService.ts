export interface AudioChain {
  name: string;
  effects: string[];
}

export class AudioEffectService {
  loadPreset(presetName: string): AudioChain {
    return { name: presetName, effects: [] };
  }
}
