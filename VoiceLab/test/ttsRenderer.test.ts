import { TTSRenderer } from '../src/TTSRenderer';

test('TTSRenderer processes queued segments', async () => {
  const renderer = new TTSRenderer({ concurrency: 2 });
  renderer.enqueue({ id: '1', text: 'hello' });
  renderer.enqueue({ id: '2', text: 'world' });
  await new Promise((res) => setTimeout(res, 50));
  expect(renderer.isIdle()).toBe(true);
});

test('latency spike callback fires', async () => {
  const { renderSegment } = await import('../src/ttsService');
  (renderSegment as jest.Mock).mockImplementationOnce(async () => {
    await new Promise((r) => setTimeout(r, 60));
    return new Blob(['a']);
  });
  const spikes: number[] = [];
  const renderer = new TTSRenderer({
    onLatencySpike: (latency) => spikes.push(latency),
    latencyThreshold: 50,
  });
  renderer.enqueue({ id: 'slow', text: 'test' });
  await new Promise((r) => setTimeout(r, 80));
  expect(spikes.length).toBe(1);
});
