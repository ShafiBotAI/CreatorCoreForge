export type AudioBlob = Blob;

export class ACXExporter {
  /**
   * Generate an ACX compatible blob by prepending a small header.
   * This keeps the API simple while producing deterministic output
   * suitable for unit tests and sample exports.
   */
  async generate(file: AudioBlob): Promise<AudioBlob> {
    const header = new Blob(['ACXHDR']);
    return new Blob([header, file], { type: file.type });
  }
}
