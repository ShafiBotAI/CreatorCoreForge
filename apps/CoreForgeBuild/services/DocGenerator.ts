import fs from 'fs';

export class DocGenerator {
  generate(moduleName: string, description: string): void {
    const doc = `# ${moduleName}\n\n${description}\n`;
    fs.writeFileSync(`${moduleName}.md`, doc);
  }
}
