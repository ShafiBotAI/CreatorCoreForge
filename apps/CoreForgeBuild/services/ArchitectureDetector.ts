export type Architecture = 'spa' | 'mvc' | 'mvvm' | 'unknown';

/** Detect simple architecture keywords from a prompt or UI map. */
export class ArchitectureDetector {
  detect(text: string): Architecture {
    const lower = text.toLowerCase();
    if (lower.includes('single page') || lower.includes('spa')) {
      return 'spa';
    }
    if (lower.includes('model-view-controller') || lower.includes('mvc')) {
      return 'mvc';
    }
    if (lower.includes('mvvm')) {
      return 'mvvm';
    }
    return 'unknown';
  }
}
