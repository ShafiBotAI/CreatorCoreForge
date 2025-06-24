import { diffLines } from 'diff';

export class DiffService {
  diff(oldStr: string, newStr: string): string {
    const parts = diffLines(oldStr, newStr);
    return parts
      .map(p => {
        const prefix = p.added ? '+' : p.removed ? '-' : ' ';
        return p.value
          .split('\n')
          .filter(Boolean)
          .map(line => `${prefix}${line}`)
          .join('\n');
      })
      .join('\n');
  }
}
