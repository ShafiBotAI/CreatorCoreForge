import type { Segment } from './segmentation';

export interface CastConfig {
  [character: string]: string;
}

export function mapCharactersToVoices(segments: Segment[], cast: CastConfig): Segment[] {
  return segments.map(seg => {
    const match = seg.text.match(/^([\w ]+):/);
    const key = match ? match[1].trim() : 'narrator';
    const voiceId = cast[key] || cast['narrator'];
    return { ...seg, voiceId };
  });
}
