import { TranscriptGenerator } from '../src/transcriptGenerator';

test('TranscriptGenerator exposes generateTranscript', () => {
  const generator = new TranscriptGenerator({ apiKey: 'test-key' });
  expect(typeof generator.generateTranscript).toBe('function');
});
