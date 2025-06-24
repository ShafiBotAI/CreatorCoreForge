export function mergeScenes(scenes: string[], index: number): string[] {
  if (index < 0 || index >= scenes.length - 1) return scenes.slice();
  const merged = scenes.slice(0, index);
  merged.push(scenes[index] + ' ' + scenes[index + 1]);
  return merged.concat(scenes.slice(index + 2));
}
