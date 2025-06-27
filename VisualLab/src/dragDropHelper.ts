export function detectBookFormat(fileName: string): string {
  const lower = fileName.toLowerCase();
  if (lower.endsWith('.epub')) return 'epub';
  if (lower.endsWith('.pdf')) return 'pdf';
  if (lower.endsWith('.txt')) return 'txt';
  if (lower.endsWith('.docx') || lower.endsWith('.doc')) return 'docx';
  if (lower.endsWith('.md') || lower.endsWith('.markdown')) return 'markdown';
  return 'unknown';
}
