import { AudioProcessor } from '../src/dynamicRangeCompressor';

function blobFromSamples(samples: number[]): Blob {
  const arr = new Float32Array(samples);
  return new Blob([arr.buffer]);
}

test('compress attenuates samples above threshold', async () => {
  const processor = new AudioProcessor();
  const input = blobFromSamples([0.2, 0.8, -0.9]);
  const out = await processor.compress(input, 0.5, 2);
  const data = new Float32Array(await out.arrayBuffer());
  expect(data[0]).toBeCloseTo(0.2);
  expect(data[1]).toBeCloseTo(0.5 + (0.8 - 0.5) / 2);
  expect(data[2]).toBeCloseTo(-(0.5 + (0.9 - 0.5) / 2));
});
