export function audioSyncService(duration: number, frames: number): number[] {
  const step = duration / frames;
  return Array.from({ length: frames }, (_, i) => i * step);
}
