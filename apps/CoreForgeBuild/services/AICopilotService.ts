/**
 * Very lightweight AI co-pilot stub for Phase 8.
 * Analyzes code strings and returns simple suggestions
 * for refactoring or improvements.
 */
export class AICopilotService {
  suggestRefactor(code: string): string[] {
    const suggestions: string[] = [];
    const lines = code.split(/\r?\n/);
    if (lines.length > 50) {
      suggestions.push('Function is quite long; consider breaking it into smaller parts.');
    }
    if (/eval\(/.test(code)) {
      suggestions.push('Avoid using eval for security reasons.');
    }
    if (/function\s+\w+\([^)]*\)\s*{[^}]*await[^}]*await/.test(code)) {
      suggestions.push('Mixed async flow detected; review for proper await usage.');
    }
    return suggestions;
  }
}
