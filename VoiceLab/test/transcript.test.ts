import { TranscriptGenerator } from '../src/transcriptGenerator';

test('TranscriptGenerator exposes generateTranscript', () => {
  const gen = new TranscriptGenerator({ apiKey: 'k' });
  expect(typeof gen.generateTranscript).toBe('function');
});
