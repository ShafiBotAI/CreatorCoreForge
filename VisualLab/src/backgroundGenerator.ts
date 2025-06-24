export function generateBackground(mood: string): string {
  const map: Record<string, string> = {
    happy: 'blue-sky',
    sad: 'grey-clouds',
    angry: 'storm-red',
  };
  return map[mood] ?? 'default-background';
}

export function generateHeroSpotlightWideBackground(hero: string, mood = 'neutral'): string {
  const base = generateBackground(mood);
  return `${base}-hero-${hero}-soft-spotlight-wide`;
}
