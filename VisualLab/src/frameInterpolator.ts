export function interpolateFrames(frames: string[]): string[] {
  if (frames.length <= 1) return frames.slice();
  const result: string[] = [];
  for (let i = 0; i < frames.length - 1; i++) {
    const current = frames[i];
    const next = frames[i + 1];
    result.push(current);
    result.push(`${current}-${next}-interp`);
  }
  result.push(frames[frames.length - 1]);
  return result;
}
