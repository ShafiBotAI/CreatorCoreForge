export function applyWatermark(frame: string, watermark: string): string {
  return `${frame}-wm(${watermark})`;
}
