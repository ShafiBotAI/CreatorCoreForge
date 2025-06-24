export function detectBookFormat(fileName: string): string | null {
  const lower = fileName.toLowerCase();
  if (lower.endsWith('.epub')) return 'epub';
  if (lower.endsWith('.pdf')) return 'pdf';
  if (lower.endsWith('.txt')) return 'txt';
  return null;
}
