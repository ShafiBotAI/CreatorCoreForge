export async function exportBook(audioBlobs: Blob[], format: 'mp3'|'wav'|'srt'): Promise<Blob> {
  const type = format === 'srt' ? 'text/plain' : `audio/${format}`;
  return new Blob(audioBlobs, { type });
}
