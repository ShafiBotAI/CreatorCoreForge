export interface SignFrame {
  start: number; // seconds
  end: number;
  symbol: string;
}

export interface VideoOverlay {
  frames: SignFrame[];
}

export class SignLanguageService {
  /**
   * Very lightweight sign language overlay generator.
   * Splits the audio into small chunks and assigns a
   * simple "wave" or "idle" symbol based on amplitude.
   */
  async generateOverlay(audio: Blob): Promise<VideoOverlay> {
    const buf = Buffer.from(await audio.arrayBuffer());
    const chunkSize = 2048;
    const frames: SignFrame[] = [];
    for (let i = 0; i < buf.length; i += chunkSize) {
      const chunk = buf.slice(i, i + chunkSize);
      if (chunk.length === 0) continue;
      const avg =
        chunk.reduce((sum, b) => sum + Math.abs(b - 128), 0) / chunk.length;
      const symbol = avg > 30 ? 'wave' : 'idle';
      const index = i / chunkSize;
      frames.push({ start: index * 0.1, end: (index + 1) * 0.1, symbol });
    }
    return { frames };
  }
}
