import {
  generateBackground,
  MotionBlurService,
  applyDepthOfField,
  semanticTagger,
  colorPaletteExtractor,
  multiAngleRenderer,
  ModelInserter,
  streamingOptimizer,
  CacheManager,
  sceneTransitionGenerator,
  TextOverlayService,
  audioSyncService,
  RenderQueueManager,
  ErrorRecoveryService,
  thumbnailGenerator,
  PerformanceProfiler
} from '../src/index.ts';
import assert from 'node:assert';

assert.strictEqual(generateBackground('happy'), 'blue-sky');
assert.ok(new CacheManager<string>());
assert.deepStrictEqual(multiAngleRenderer('scene1', [1,2]), ['scene1-angle-1','scene1-angle-2']);
assert.deepStrictEqual(colorPaletteExtractor(['red','red','blue'],1), ['red']);
assert.ok(sceneTransitionGenerator('fade'));
semanticTagger("love battle");
const mb=new MotionBlurService(); mb.apply([[1,2]],0.1); applyDepthOfField([[1,2]]); streamingOptimizer([Buffer.from("a")],1000); new ModelInserter().insert("scene","model"); const service = new TextOverlayService();
assert.strictEqual(service.apply('frame','text'),'frame-text(text)');
assert.ok(audioSyncService(10, 2).length === 2);
const queue = new RenderQueueManager();
queue.add({id:'a', priority:1, task:async()=>{}});
await queue.runNext();
new ErrorRecoveryService();
thumbnailGenerator([Buffer.from('a')]);
new PerformanceProfiler().end();
console.log('VisualLab tests passed');
