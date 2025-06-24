export interface Metadata {
  title: string;
  author: string;
}

export function addMetadata(video: Buffer, data: Metadata): Buffer {
  return Buffer.concat([Buffer.from(JSON.stringify(data)), video]);
}
