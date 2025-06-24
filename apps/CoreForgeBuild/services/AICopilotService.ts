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
  annotate(code: string): string {
    return code
      .split(/\n/)
      .map((l, i) => `// ${i + 1} ${l}`)
      .join('\n');
  }

  logicHints(code: string): string[] {
    const hints: string[] = [];
    if (code.includes('if') && !code.includes('else')) {
      hints.push('Consider handling the else case.');
    }
    return hints;
  }

  recommendExtraction(code: string): string[] {
    return code
      .split(/function\s+/)
      .filter(s => s.split(/\n/).length > 40)
      .map((_, i) => `Function ${i + 1} may be too large`);
  }

  alternativeModule(module: string): string[] {
    return [`Use optimized-${module}`, `Consider minimalist-${module}`];
  }

  handleQuery(query: string, code: string): string {
    if (query.toLowerCase().includes('optimize')) {
      return this.suggestRefactor(code).join('\n');
    }
    return 'No answer';
  }

  generateTests(name: string): string[] {
    return [`${name} should succeed`, `${name} should fail gracefully`];
  }

  detectAntiPatterns(code: string): string[] {
    const warnings: string[] = [];
    if (code.includes('var ')) warnings.push('Use let/const instead of var');
    if (code.includes('callback(')) warnings.push('Consider using Promises or async/await');
    return warnings;
  }

  explain(reason: string): string {
    return `Decision rationale: ${reason}`;
  }

  recordAccepted(log: string, logger: { record(msg: string): void }) {
    logger.record(log);
  }

  voiceCommand(cmd: string): string {
    return `Executing voice command: ${cmd}`;
  }

  dataStructureAdvice(complexity: number): string {
    return complexity > 10 ? 'Use a Map for faster lookups' : 'Array is sufficient';
  }

  performanceForecast(lines: number): string {
    return lines > 200 ? 'Potential slowdowns detected' : 'No major impact';
  }

  securityHints(code: string): string[] {
    const { SecurityScanner } = require('./SecurityScanner');
    return new SecurityScanner().scan(code);
  }

  asyncHint(code: string): string {
    return code.includes('await') && code.includes('.forEach')
      ? 'for...of may be more appropriate with async/await'
      : 'Looks ok';
  }

  document(name: string): string {
    return `## ${name}\nAuto-generated documentation.`;
  }
}
