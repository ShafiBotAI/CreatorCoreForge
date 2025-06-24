import fs from 'fs';
import path from 'path';
import { DiffService } from './DiffService';

export class ChangeLogService {
  private dir = path.join(process.cwd(), 'dist');
  private diff = new DiffService();

  log(projectId: string, message: string) {
    const file = path.join(this.dir, `${projectId}_changelog.txt`);
    fs.mkdirSync(this.dir, { recursive: true });
    fs.appendFileSync(file, `${new Date().toISOString()} - ${message}\n`);
  }

  getLog(projectId: string): string {
    const file = path.join(this.dir, `${projectId}_changelog.txt`);
    try {
      return fs.readFileSync(file, 'utf8');
    } catch {
      return '';
    }
  }

  deploymentDiff(oldDir: string, newDir: string): string {
    try {
      const oldStr = fs.readFileSync(oldDir, 'utf8');
      const newStr = fs.readFileSync(newDir, 'utf8');
      return this.diff.diff(oldStr, newStr);
    } catch {
      return '';
    }
  }
}
