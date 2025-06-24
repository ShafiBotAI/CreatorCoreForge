import fs from 'fs';
import path from 'path';

export interface CreativeDNA {
  team?: string;
  whiteLabel?: boolean;
  preferences?: Record<string, any>;
}

/**
 * CreativeDNAService stores user or team preferences that
 * influence generated apps. Data is persisted to a simple
 * JSON file for demo purposes.
 */
export class CreativeDNAService {
  private file = path.join(__dirname, '..', 'creative_dna.json');

  load(): CreativeDNA {
    if (fs.existsSync(this.file)) {
      return JSON.parse(fs.readFileSync(this.file, 'utf8')) as CreativeDNA;
    }
    return {};
  }

  save(dna: CreativeDNA): void {
    fs.writeFileSync(this.file, JSON.stringify(dna, null, 2));
  }
}
