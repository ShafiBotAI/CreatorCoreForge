import { TranscriptGenerator } from '../src/transcriptGenerator';

test('TranscriptGenerator has generate function', () => {
  const generator = new TranscriptGenerator({ apiKey: 'test-key' });
  expect(typeof generator.generateTranscript).toBe('function');
});
