export interface Chapter {
  title: string;
  text: string;
}

function normalize(text: string): string {
  return text.replace(/\s+/g, ' ').trim();
}

export async function importBook(file: File): Promise<Chapter[]> {
  const ext = file.name.split('.').pop()?.toLowerCase();
  const raw = await file.text();
  const text = raw;

  if (ext === 'txt') {
    return raw.split(/\n\s*\n/).filter(Boolean).map((t, i) => ({
      title: `Chapter ${i + 1}`,
      text: normalize(t)
    }));
  }

  if (ext === 'epub' || ext === 'pdf') {
    return [{ title: file.name, text: normalize(text) }];
  }

  throw new Error('Unsupported format');
}
