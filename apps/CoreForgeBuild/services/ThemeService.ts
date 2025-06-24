/**
 * ThemeService suggests basic design themes based on a brand string
 * and can generate simple CSS for dark/light modes.
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

  css(mode: 'dark' | 'light'): string {
    return mode === 'dark'
      ? 'body { background:#000; color:#fff; }'
      : 'body { background:#fff; color:#000; }';
  }
}
