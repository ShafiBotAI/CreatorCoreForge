import { ARService, GPUVideoRenderer } from '../src';

test('ARService previewScene resolves', async () => {
  const svc = new ARService();
  await expect(svc.previewScene({ id: '1' })).resolves.toBeUndefined();
});

test('GPUVideoRenderer returns clip', async () => {
  const gpu = new GPUVideoRenderer();
  const clip = await gpu.render([], { width: 100, height: 100 });
  expect(clip.frames.length).toBe(0);
});
