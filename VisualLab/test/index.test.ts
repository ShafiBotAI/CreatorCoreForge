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
  PerformanceProfiler,
  generateHeroSpotlightWideBackground
} from '../src/index.ts';
import { VideoStreamingService } from '../src/streamingService.ts';
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
const streaming = new VideoStreamingService(1000);
streaming.registerProject('p', [Buffer.from('f1'), Buffer.from('f2')]);
const recv: Buffer[] = [];
for await (const c of await streaming.stream('p')) recv.push(c);
assert.strictEqual(Buffer.concat(recv).toString(), 'f1f2');
assert.strictEqual(generateHeroSpotlightWideBackground('hero', 'happy'), 'blue-sky-hero-hero-soft-spotlight-wide');
console.log('VisualLab tests passed');
