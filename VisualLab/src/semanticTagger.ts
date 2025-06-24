export function semanticTagger(text: string): string[] {
  const tags: string[] = [];
  if (/fight|battle/i.test(text)) tags.push('action');
  if (/love|romance/i.test(text)) tags.push('romance');
  if (/sad|tears/i.test(text)) tags.push('drama');
  return tags;
}
