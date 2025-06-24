import { UIElement } from '../models/UIElement';

/**
 * Simple check for platform specific requirements like iOS privacy labels.
 */
export class PlatformConstraintService {
  check(layout: UIElement[]): string[] {
    const issues: string[] = [];
    const text = JSON.stringify(layout).toLowerCase();
    if (text.includes('camera')) {
      issues.push('iOS requires camera usage description');
    }
    if (text.includes('microphone')) {
      issues.push('iOS requires microphone usage description');
    }
    return issues;
  }
}
