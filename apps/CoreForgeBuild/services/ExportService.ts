/**
 * ExportService returns different variants of code for preview or production.
 */
export class ExportService {
  export(code: string, mode: 'raw' | 'annotated' | 'production'): string {
    if (mode === 'annotated') {
      return `// annotated\n${code}`;
    }
    if (mode === 'production') {
      return code.replace(/console\.log\([^)]*\);?/g, '');
    }
    return code;
  }
}
