export function multiAngleRenderer(sceneId: string, angles: number[]): string[] {
  return angles.map(a => `${sceneId}-angle-${a}`);
}
