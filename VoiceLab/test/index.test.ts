import { LocalVoiceAI } from '../src/voiceModels.ts';
import { VoiceAnalyticsService } from '../src/VoiceAnalyticsService.ts';
import assert from 'node:assert';

const engine = new LocalVoiceAI();
const sample = new Blob(['audio']);
const model = await engine.trainVoiceModel(sample, 'speaker1');
assert.ok(model.id && model.speakerId === 'speaker1');

const styled = await engine.transferVoiceStyle(model, 'whisper');
assert.ok(styled.style === 'whisper');

const exported = await engine.exportVoiceModel(model.id, 'onnx');
assert.ok(exported.size > 0);

const metrics = await new VoiceAnalyticsService().analyze(sample);
assert.ok(typeof metrics.pitch === 'number');
console.log('All VoiceLab tests passed');
