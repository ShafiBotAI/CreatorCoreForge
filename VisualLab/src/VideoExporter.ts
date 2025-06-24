export function exportVideoMP4(frames: Buffer[]): Buffer {
  return Buffer.concat([Buffer.from('MP4'), ...frames]);
}
