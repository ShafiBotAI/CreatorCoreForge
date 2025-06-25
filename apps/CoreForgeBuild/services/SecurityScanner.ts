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
  scanInputs(fields: string[]): string[] {
    const issues: string[] = [];
    for (const f of fields) {
      if (/password/i.test(f) && !/type=\"password\"/.test(f)) {
        issues.push('Password field should use type="password"');
      }
      if (/onerror=/.test(f)) {
        issues.push('Potential XSS vulnerability in input');
      }
    }
    return issues;
  }
}
