import { VisualRenderer } from '../src/VisualRenderer.ts';
import { UnifiedVideoEngine } from '../src/UnifiedVideoEngine.ts';
import assert from 'node:assert';

test('VisualRenderer uses UnifiedVideoEngine to render frames', async () => {
  const engine = new UnifiedVideoEngine();
  const renderer = new VisualRenderer(engine);
  const clip = await renderer.render({
    frames: [Buffer.from('a')],
    resolution: { width: 1, height: 1 },
  });
  assert.strictEqual(clip.frames.length, 1);
});
