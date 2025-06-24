export function fuseScenes(a: string[], b: string[]): string[] {
  return a.map((frame, i) => `${frame}|${b[i] || ''}`);
}
