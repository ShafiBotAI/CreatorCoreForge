export function matchLocationToTemplate(location: string): string {
  const templates: Record<string, string[]> = {
    castle: ['castle', 'fortress', 'palace'],
    school: ['school', 'academy', 'university'],
    'space station': ['space station', 'orbital', 'astro-base']
  };
  const lower = location.toLowerCase();
  for (const [template, keywords] of Object.entries(templates)) {
    if (keywords.some(k => lower.includes(k))) {
      return template;
    }
  }
  return 'generic';
}
