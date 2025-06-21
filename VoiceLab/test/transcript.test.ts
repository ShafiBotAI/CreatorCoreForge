import assert from 'node:assert';
import { TranscriptGenerator } from '../src/transcriptGenerator.ts';

const generator = new TranscriptGenerator({ apiKey: 'test-key' });
assert.ok(typeof generator.generateTranscript === 'function');
console.log('TranscriptGenerator basic test passed');
