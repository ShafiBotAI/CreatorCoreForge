import { GroupListenService, PronunciationService, UnifiedAudioEngine, UnifiedVideoEngine, AdaptiveLearningEngine } from '../src';

test('GroupListenService can create room', async () => {
  const svc = new GroupListenService();
  const room = await svc.createRoom('book1');
  expect(room.bookId).toBe('book1');
});

test('PronunciationService suggests phonemes', async () => {
  const svc = new PronunciationService();
  const result = await svc.suggestCorrections('Hello World');
  expect(result).toEqual(['hello', 'world']);
});

test('UnifiedAudioEngine volume clamp', () => {
  const engine = UnifiedAudioEngine.shared;
  engine.setVolume(2);
  expect(engine.currentVolume()).toBe(1);
  engine.mute();
  expect(engine.isMuted()).toBe(true);
  engine.unmute();
  const levels = engine.fadeVolumeTo(0.5, 2);
  expect(levels.length).toBe(2);
  expect(levels[levels.length - 1]).toBeCloseTo(0.5);
});

test('UnifiedVideoEngine renders frames', async () => {
  const engine = UnifiedVideoEngine.shared;
  const clip = await engine.render(['a'], { width: 1, height: 1 });
  expect(clip.frames.length).toBe(1);
});

test('AdaptiveLearningEngine records progress', () => {
  const engine = AdaptiveLearningEngine.shared;
  engine.reset();
  engine.recordCompletion('l');
  expect(engine.completionCount('l')).toBe(1);
});
