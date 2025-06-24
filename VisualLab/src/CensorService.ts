export function censorLayer(frame: string, level: number): string {
  return level > 0 ? `${frame}-censored-${level}` : frame;
}
