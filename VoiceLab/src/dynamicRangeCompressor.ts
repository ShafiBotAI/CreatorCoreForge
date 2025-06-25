export type AudioBlob = Blob;

/**
 * Basic dynamic range compressor for audio blobs containing
 * 32-bit float samples. Samples above the provided threshold
 * are attenuated using the given ratio.
 */
export interface CompressionOptions {
  /**
   * Normalized amplitude threshold (0-1)
   */
  threshold?: number;
  /**
   * Ratio used once the threshold is exceeded (>1)
   */
  ratio?: number;
  /**
   * Attack time in seconds for smoothing gain reduction
   */
  attack?: number;
  /**
   * Release time in seconds for smoothing gain increase
   */
  release?: number;
  /**
   * Linear multiplier applied after compression
   */
  makeupGain?: number;
  /**
   * Sample rate of the audio buffer
   */
  sampleRate?: number;
}

export class AudioProcessor {
  async compress(
    input: AudioBlob,
    {
      threshold = 0.6,
      ratio = 4,
      attack = 0,
      release = 0,
      makeupGain = 1,
      sampleRate = 44100,
    }: CompressionOptions = {}
  ): Promise<AudioBlob> {
    if (threshold < 0 || threshold > 1) throw new Error('threshold out of range');
    if (ratio <= 0) throw new Error('ratio must be > 0');
    if (attack < 0 || release < 0) throw new Error('attack/release must be >= 0');
    if (sampleRate <= 0) throw new Error('sampleRate must be > 0');

    const buffer = Buffer.from(await input.arrayBuffer());
    const samples = new Float32Array(
      buffer.buffer,
      buffer.byteOffset,
      Math.floor(buffer.byteLength / 4)
    );

    const attackCoef = attack > 0 ? Math.exp(-1 / (attack * sampleRate)) : 0;
    const releaseCoef = release > 0 ? Math.exp(-1 / (release * sampleRate)) : 0;
    let gain = 1;

    for (let i = 0; i < samples.length; i++) {
      const abs = Math.abs(samples[i]);
      let desiredGain = 1;
      if (abs > threshold) {
        const excess = abs - threshold;
        desiredGain = 1 / (1 + excess * (ratio - 1));
      }
      if (desiredGain < gain) {
        const diff = gain - desiredGain;
        gain = desiredGain + diff * attackCoef;
      } else {
        const diff = gain - desiredGain;
        gain = desiredGain + diff * releaseCoef;
      }
      samples[i] *= gain * makeupGain;
    }

    return new Blob([samples.buffer], { type: input.type || 'application/octet-stream' });
  }
}
