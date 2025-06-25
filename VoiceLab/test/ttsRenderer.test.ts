import { TTSRenderer } from '../src/TTSRenderer';

test('TTSRenderer processes queued segments', async () => {
  const renderer = new TTSRenderer({ concurrency: 2 });
  renderer.enqueue({ id: '1', text: 'hello' });
  renderer.enqueue({ id: '2', text: 'world' });
  await new Promise((res) => setTimeout(res, 50));
  expect(renderer.isIdle()).toBe(true);
});
