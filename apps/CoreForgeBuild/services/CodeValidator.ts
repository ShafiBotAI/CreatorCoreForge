/**
 * CodeValidator performs tiny checks for deprecated patterns.
 */
export class CodeValidator {
  validate(code: string): string[] {
    const warnings: string[] = [];
    if (code.includes('var ')) {
      warnings.push('Use let/const instead of var');
    }
    if (code.includes('document.write')) {
      warnings.push('Avoid document.write for security reasons');
    }
    return warnings;
  }
}
