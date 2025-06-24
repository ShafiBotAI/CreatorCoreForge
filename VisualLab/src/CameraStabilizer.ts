export function stabilizeCamera(frames: number[][][]): number[][][] {
  if (frames.length === 0) return [];
  const out: number[][][] = [frames[0]];
  for (let i = 1; i < frames.length; i++) {
    const prev = frames[i - 1];
    const cur = frames[i];
    out[i] = cur.map((row, y) =>
      row.map((val, x) => Math.round((val + (prev[y]?.[x] ?? val)) / 2))
    );
  }
  return out;
}
