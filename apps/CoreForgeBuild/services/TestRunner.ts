import { execSync } from 'child_process';

export class TestRunner {
  static runJest(): void {
    execSync('npx jest', { stdio: 'inherit' });
  }
}
