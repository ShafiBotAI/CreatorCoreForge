import { modulateCadence, simulateInterrupt, generateStutterLaugh, applyWhisper, switchToneMidSentence } from '../src/voiceEffects';

test('modulateCadence alternates amplitude', () => {
  const result = modulateCadence([1, 1, 1, 1], 0.5);
  expect(result[0]).toBeCloseTo(1.5);
  expect(result[1]).toBeCloseTo(0.5);
});

test('simulateInterrupt inserts silence at points', () => {
  const result = simulateInterrupt([1, 1, 1], [1]);
  expect(result).toEqual([1, 0, 1]);
});

test('generateStutterLaugh repeats base with pauses', () => {
  const result = generateStutterLaugh([1, 2], 2);
  expect(result).toEqual([1, 2, 0, 1, 2, 0]);
});

test('applyWhisper reduces volume in range', () => {
  const result = applyWhisper([1, 1, 1], 0, 1);
  expect(result).toEqual([0.5, 0.5, 1]);
});

test('switchToneMidSentence scales after index', () => {
  const result = switchToneMidSentence([1, 1, 1], 1, 2);
  expect(result).toEqual([1, 2, 2]);
});
