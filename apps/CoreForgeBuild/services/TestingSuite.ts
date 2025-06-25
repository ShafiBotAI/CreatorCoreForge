import { execSync } from 'child_process';

export class TestingSuite {
  /** Generate a dummy test case */
  generate(module: string): string[] {
    return [`should test ${module}`, `should validate ${module}`];
  }

  /** Run npm test and return whether it succeeded */
  run(): boolean {
    try {
      execSync('npm test --workspaces', { stdio: 'ignore' });
      return true;
    } catch {
      return false;
    }
  }
}
