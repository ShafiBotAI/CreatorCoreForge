import type { Chapter } from './importer';

export interface Segment {
  id: string;
  text: string;
  chapter: number;
  voiceId?: string;
}

export async function autoSegment(chapters: Chapter[]): Promise<Segment[]> {
  const segments: Segment[] = [];
  chapters.forEach((chap, idx) => {
    const parts = chap.text.split(/\n\s*\n/);
    for (const p of parts) {
      const text = p.trim();
      if (!text) continue;
      segments.push({
        id: `seg-${segments.length}`,
        text,
        chapter: idx
      });
    }
  });
  return segments;
}
