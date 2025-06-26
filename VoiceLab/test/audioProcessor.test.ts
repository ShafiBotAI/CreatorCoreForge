import { AudioProcessor } from '../src/dynamicRangeCompressor';

function blobFromSamples(samples: number[]): Blob {
  const arr = new Float32Array(samples);
  return new Blob([arr.buffer]);
}

test('compress attenuates samples above threshold', async () => {
  const processor = new AudioProcessor();
  const input = blobFromSamples([0.2, 0.8, -0.9]);
  const out = await processor.compress(input, {
    threshold: 0.5,
    ratio: 2,
    attack: 0,
    release: 0,
  });
  const data = new Float32Array(await out.arrayBuffer());
  expect(data[0]).toBeCloseTo(0.2);
  expect(data[1]).toBeCloseTo(0.8 * (1 / (1 + (0.8 - 0.5))));
  expect(data[2]).toBeCloseTo(-0.9 * (1 / (1 + (0.9 - 0.5))));
});

test('attack smoothing delays full compression', async () => {
  const processor = new AudioProcessor();
  const input = blobFromSamples([0.8, 0.8]);
  const immediate = await processor.compress(input, {
    threshold: 0.5,
    ratio: 2,
    attack: 0,
    release: 0,
    sampleRate: 1000,
  });
  const slow = await processor.compress(input, {
    threshold: 0.5,
    ratio: 2,
    attack: 0.1,
    release: 0.1,
    sampleRate: 1000,
  });
  const imm = new Float32Array(await immediate.arrayBuffer());
  const slw = new Float32Array(await slow.arrayBuffer());
  expect(slw[0]).toBeGreaterThan(imm[0]);
});
