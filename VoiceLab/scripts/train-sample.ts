import { LocalVoiceAI } from '../src/voiceModels';

(async () => {
  const engine = new LocalVoiceAI();
  const sample = new Blob(['audio']);
  const model = await engine.trainVoiceModel(sample, 'sample-speaker');
  console.log('Trained model', model);
})();
