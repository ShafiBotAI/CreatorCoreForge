export interface StoryboardItem {
  index: number;
  text: string;
}

export function generateStoryboard(scenes: string[]): StoryboardItem[] {
  return scenes.map((s, i) => ({ index: i, text: s.trim() }));
}
