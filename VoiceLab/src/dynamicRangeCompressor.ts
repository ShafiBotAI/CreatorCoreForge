export type AudioBlob = Blob;

export class AudioProcessor {
  async compress(input: AudioBlob): Promise<AudioBlob> {
    return input;
  }
}
