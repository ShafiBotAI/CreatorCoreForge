export type AudioBlob = Blob;

export class ACXExporter {
  async generate(file: AudioBlob): Promise<AudioBlob> {
    return file;
  }
}
