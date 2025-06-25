export type AudioBlob = Blob;

/**
 * Basic dynamic range compressor for audio blobs containing
 * 32-bit float samples. Samples above the provided threshold
 * are attenuated using the given ratio.
 */
export class AudioProcessor {
  async compress(
    input: AudioBlob,
    threshold = 0.6,
    ratio = 4
  ): Promise<AudioBlob> {
    const buffer = Buffer.from(await input.arrayBuffer());
    const samples = new Float32Array(
      buffer.buffer,
      buffer.byteOffset,
      Math.floor(buffer.byteLength / 4)
    );
    for (let i = 0; i < samples.length; i++) {
      const s = samples[i];
      const abs = Math.abs(s);
      if (abs > threshold) {
        const sign = Math.sign(s);
        const excess = abs - threshold;
        samples[i] = sign * (threshold + excess / ratio);
      }
    }
    return new Blob([samples.buffer], { type: input.type || 'application/octet-stream' });
  }
}
