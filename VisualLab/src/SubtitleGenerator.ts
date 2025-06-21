export interface Subtitle { time: number; text: string; }

export function generateSubtitles(script: string): Subtitle[] {
  return script.split(/\n+/).map((line, i) => ({ time: i, text: line }));
}
