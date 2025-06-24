import fs from 'fs';
import path from 'path';

export interface DeployRecord {
  date: string;
  platform: string;
  notes?: string;
}

export class DeployHistory {
  constructor(private file = path.join(process.cwd(), 'dist', 'deploy_history.json')) {}

  log(record: DeployRecord): void {
    const history = this.read();
    history.push(record);
    fs.mkdirSync(path.dirname(this.file), { recursive: true });
    fs.writeFileSync(this.file, JSON.stringify(history, null, 2));
  }

  read(): DeployRecord[] {
    try {
      return JSON.parse(fs.readFileSync(this.file, 'utf8'));
    } catch {
      return [];
    }
  }
}
