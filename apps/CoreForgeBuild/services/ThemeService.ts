/**
 * ThemeService suggests basic design themes based on a brand string.
 */
export class ThemeService {
  suggestThemes(brand: string): string[] {
    const lower = brand.toLowerCase();
    if (lower.includes('dark')) {
      return ['dark', 'neon'];
    }
    if (lower.includes('light')) {
      return ['clean', 'minimal'];
    }
    return ['modern', 'classic'];
  }
}
