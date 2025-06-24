/**
 * Simple security scanner for Phase 9 that checks code strings
 * for potential issues such as use of eval or insecure HTTP links.
 */
export class SecurityScanner {
  scan(code: string): string[] {
    const warnings: string[] = [];
    if (/eval\(/.test(code)) {
      warnings.push('Use of eval detected');
    }
    if (/http:\/\//.test(code)) {
      warnings.push('Insecure HTTP link found');
    }
    return warnings;
  }
}
