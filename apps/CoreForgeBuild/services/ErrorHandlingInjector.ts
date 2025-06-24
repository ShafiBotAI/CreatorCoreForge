/**
 * ErrorHandlingInjector wraps asynchronous code blocks with
 * a basic try/catch template. This is a lightweight helper
 * for early testing purposes.
 */
export class ErrorHandlingInjector {
  inject(code: string): string {
    return `try {\n${code}\n} catch (e) {\n  console.error(e);\n}`;
  }
}
