export class EncryptionService {
  async encrypt(blob: Blob): Promise<Blob> {
    const base64 = await blob.arrayBuffer().then(buf => Buffer.from(buf).toString('base64'));
    return new Blob([base64]);
  }

  async decrypt(blob: Blob): Promise<Blob> {
    const text = await blob.text();
    const buf = Buffer.from(text, 'base64');
    return new Blob([buf]);
  }
}
