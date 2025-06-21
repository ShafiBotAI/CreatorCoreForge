import type { Segment } from './segmentation';

export async function renderSegment(segment: Segment, voiceId: string): Promise<Blob> {
  const data = new Blob([`voice:${voiceId}\n${segment.text}`], { type: 'audio/wav' });
  await new Promise(r => setTimeout(r, 10));
  return data;
}
