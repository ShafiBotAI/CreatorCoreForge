export function colorPaletteExtractor(colors: string[], count = 3): string[] {
  const unique = Array.from(new Set(colors));
  return unique.slice(0, count);
}
