export interface VoiceMetrics {
  pitch: number;
  timbre: number;
  rate: number;
  valence: number;
}

export class VoiceAnalyticsService {
  /**
   * Naive analytics based on raw byte data. This avoids heavy
   * dependencies while providing deterministic metrics for tests.
   */
  async analyze(audio: Blob): Promise<VoiceMetrics> {
    const buffer = await audio.arrayBuffer();
    const data = new Uint8Array(buffer);
    if (data.length === 0) {
      return { pitch: 0, timbre: 0, rate: 0, valence: 0 };
    }

    let sum = 0;
    let diff = 0;
    for (let i = 0; i < data.length; i++) {
      sum += data[i];
      if (i > 0) diff += Math.abs(data[i] - data[i - 1]);
    }
    const mean = sum / data.length;
    const variance = data.reduce((acc, v) => acc + (v - mean) ** 2, 0) / data.length;

    return {
      pitch: diff / data.length,
      timbre: Math.sqrt(variance),
      rate: Math.max(1, Math.round(data.length / 1000)),
      valence: Math.round(mean % 5),
    };
  }
}
