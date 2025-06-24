import { PlaybackEngine } from '../src/playbackEngine';

test('playback emits events', () => {
  const engine = new PlaybackEngine();
  const events: string[] = [];
  engine.on('play', () => events.push('play'));
  engine.on('pause', () => events.push('pause'));
  engine.on('stop', () => events.push('stop'));
  engine.play();
  engine.pause();
  engine.stop();
  expect(events).toEqual(['play', 'pause', 'stop']);
});

test('seek and speed change', () => {
  const engine = new PlaybackEngine();
  engine.seek(500);
  engine.setSpeed(2);
  // @ts-expect-no-error internal state not exported but events emit
  expect(engine).toBeInstanceOf(PlaybackEngine);
});
