export function applyDepthOfField(frame: number[][], focus = 0.5): number[][] {
  const factor = Math.max(0, Math.min(1, focus));
  return frame.map(row => row.map(v => v * factor));
}
