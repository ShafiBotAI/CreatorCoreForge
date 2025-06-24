import { LocalVoiceAI } from '../src/voiceModels';
import { VoiceAnalyticsService } from '../src/VoiceAnalyticsService';

test('voice model workflow', async () => {
  const engine = new LocalVoiceAI();
  const sample = new Blob(['audio']);
  const model = await engine.trainVoiceModel(sample, 'speaker1');
  expect(model.speakerId).toBe('speaker1');

  const styled = await engine.transferVoiceStyle(model, 'whisper');
  expect(styled.style).toBe('whisper');

  const exported = await engine.exportVoiceModel(model.id, 'onnx');
  expect(exported.size).toBeGreaterThan(0);

  const metrics = await new VoiceAnalyticsService().analyze(sample);
  expect(typeof metrics.pitch).toBe('number');
});
