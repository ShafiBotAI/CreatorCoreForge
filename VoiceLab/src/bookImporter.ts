export interface Chapter {
  title: string;
  text: string;
}

export interface ImportedBook {
  title: string;
  author?: string;
  chapters: Chapter[];
}

function normalize(text: string): string {
  return text.replace(/\s+/g, ' ').trim();
}

export class ChapterParser {
  static parse(text: string): Chapter[] {
    const blocks = text.replace(/\r\n/g, '\n').split(/\n\s*\n/).filter(b => b.trim());
    const chapters: Chapter[] = [];
    let idx = 1;
    for (const b of blocks) {
      const lines = b.trim().split(/\n+/);
      if (!lines.length) continue;
      let title = lines[0].trim();
      let start = 1;
      if (!/^chapter\b/i.test(title)) {
        title = `Chapter ${idx}`;
        start = 0;
      }
      const body = normalize(lines.slice(start).join(' '));
      if (!body) continue;
      chapters.push({ title, text: body });
      idx++;
    }
    return chapters;
  }
}

function extractMetadata(text: string, fileName: string): { title: string; author?: string; body: string } {
  const lines = text.replace(/\r\n/g, '\n').split('\n');
  let title = fileName.replace(/\.[^.]+$/, '');
  let author: string | undefined;
  let start = 0;
  if (lines[start] && /^title:/i.test(lines[start])) {
    title = lines[start].replace(/^title:/i, '').trim();
    start++;
  } else if (lines[start] && lines[start].startsWith('#')) {
    title = lines[start].replace(/^#+/, '').trim();
    start++;
  }
  if (lines[start] && /^author:/i.test(lines[start])) {
    author = lines[start].replace(/^author:/i, '').trim();
    start++;
  }
  const body = lines.slice(start).join('\n');
  return { title, author, body };
}

export class BookImporter {
  async import(file: File): Promise<ImportedBook> {
    const ext = file.name.split('.').pop()?.toLowerCase();
    const raw = await file.text();
    const { title, author, body } = extractMetadata(raw, file.name);
    let chapters: Chapter[];
    if (ext === 'txt') {
      chapters = ChapterParser.parse(body);
    } else if (ext === 'pdf' || ext === 'epub') {
      chapters = [{ title: 'Chapter 1', text: normalize(body) }];
    } else {
      throw new Error('Unsupported format');
    }
    return { title, author, chapters };
  }
}

// backwards compatibility
export async function importBook(file: File): Promise<Chapter[]> {
  const importer = new BookImporter();
  const result = await importer.import(file);
  return result.chapters;
}
