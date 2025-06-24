export function detectCharacters(scene: string): string[] {
  const regex = /\b([A-Z][a-z]+(?:\s+[A-Z][a-z]+)*)\b/g;
  const names = new Set<string>();
  let match: RegExpExecArray | null;
  while ((match = regex.exec(scene)) !== null) {
    names.add(match[1]);
  }
  return Array.from(names);
}
