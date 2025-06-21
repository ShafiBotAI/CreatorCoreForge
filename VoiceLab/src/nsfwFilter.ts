import type { Chapter } from './importer';

const WORDS = ['sex', 'nude', 'xxx'];

export function filterNSFW(chapters: Chapter[]): Chapter[] {
  const regex = new RegExp(`\\b(${WORDS.join('|')})\\b`, 'gi');
  return chapters.map(c => ({
    ...c,
    text: c.text.replace(regex, '[censored]')
  }));
}
