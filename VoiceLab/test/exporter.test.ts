import { exportBook } from '../src/exporter';

test('exportBook joins blobs', async () => {
  const b1 = new Blob(['1']);
  const b2 = new Blob(['2']);
  const out = await exportBook([b1, b2], 'mp3');
  expect(out.size).toBe(2);
});
