/**
 * AI Copilot service used by CoreForge Build.
 * This started as a small stub but now performs
 * a few real static analysis passes using the
 * TypeScript compiler API.
 */
import * as ts from 'typescript';

export class AICopilotService {
  private parse(code: string): ts.SourceFile {
    return ts.createSourceFile('tmp.ts', code, ts.ScriptTarget.Latest, true);
  }

  private visitFunctions(file: ts.SourceFile, cb: (fn: ts.FunctionLikeDeclaration, span: number) => void) {
    const visit = (node: ts.Node) => {
      if (ts.isFunctionLike(node)) {
        const span =
          file.getLineAndCharacterOfPosition(node.end).line -
          file.getLineAndCharacterOfPosition(node.pos).line;
        cb(node as ts.FunctionLikeDeclaration, span);
      }
      ts.forEachChild(node, visit);
    };
    ts.forEachChild(file, visit);
  }

  suggestRefactor(code: string): string[] {
    const suggestions: string[] = [];
    const file = this.parse(code);

    this.visitFunctions(file, (fn, span) => {
      if (span > 50) {
        const name = (fn.name && ts.isIdentifier(fn.name)) ? fn.name.text : 'anonymous';
        suggestions.push(`Function ${name} is quite long; consider breaking it into smaller parts.`);
      }
      if (fn.parameters.length > 5) {
        const name = (fn.name && ts.isIdentifier(fn.name)) ? fn.name.text : 'anonymous';
        suggestions.push(`Function ${name} has many parameters; consider refactoring.`);
      }
    });

    if (/eval\(/.test(code)) {
      suggestions.push('Avoid using eval for security reasons.');
    }

    let asyncAwaitCount = 0;
    const checkAsync = (node: ts.Node) => {
      if (ts.isAwaitExpression(node)) asyncAwaitCount++;
      ts.forEachChild(node, checkAsync);
    };
    ts.forEachChild(file, checkAsync);
    if (asyncAwaitCount > 1 && /forEach\s*\(/.test(code)) {
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
    const file = this.parse(name);
    const tests: string[] = [];
    const add = (node: ts.Node) => {
      if (ts.isFunctionLike(node) && node.name && ts.isIdentifier(node.name)) {
        const fn = node.name.text;
        tests.push(`it('${fn} works', () => {\n  const result = ${fn}();\n});`);
      }
      ts.forEachChild(node, add);
    };
    ts.forEachChild(file, add);
    return tests.length ? tests : [`${name} should succeed`, `${name} should fail gracefully`];
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
    const base = new SecurityScanner().scan(code);
    if (/child_process\.exec\(/.test(code)) {
      base.push('Usage of child_process.exec can be dangerous');
    }
    if (/https?:\/\/[^\s]*@/.test(code)) {
      base.push('Possible credential leak in URL');
    }
    return base;
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
