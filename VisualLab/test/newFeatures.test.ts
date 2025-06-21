import { ARService, GPUVideoRenderer } from '../src/index.ts';
import assert from 'node:assert';

const svc = new ARService();
await svc.previewScene({ id: '1' });

const gpu = new GPUVideoRenderer();
const clip = await gpu.render([], { width: 100, height: 100 });
assert.strictEqual(clip.frames.length, 0);

console.log('New features tests passed');
