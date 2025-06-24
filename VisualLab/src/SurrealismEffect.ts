export function applySurrealism(frames: string[], enabled: boolean): string[] {
  return enabled ? frames.map(f => `${f}-surreal`) : frames;
}
