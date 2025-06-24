export function export360VR(frames: Buffer[], format = 'mp4'): Buffer[] {
  const header = Buffer.from(`360VR-${format}`);
  return [header, ...frames];
}
