import { TTSRenderer } from '../src/TTSRenderer';

test('TTSRenderer processes queued segments', async () => {
  const renderer = new TTSRenderer();
  renderer.enqueue({ id: '1', text: 'hello' });
  renderer.enqueue({ id: '2', text: 'world' });
  await new Promise((res) => setTimeout(res, 100));
  expect(renderer.isIdle()).toBe(true);
});
