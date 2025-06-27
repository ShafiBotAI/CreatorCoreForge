import {
  ARService,
  GPUVideoRenderer,
  TimelineEditor,
  ColorGradingEngine,
  BranchingPathsUI,
  FaceTrackerService,
  CrowdSimulator,
  export360VR,
  stabilizeCamera,
  applyWatermark,
  generateSubtitles,
  RenderAnalyticsDashboard,
  interpolateFrames
} from '../src/index.ts';
import React from 'react';
import assert from 'node:assert';

const svc = new ARService();
await svc.registerModel('cube', Buffer.from('m'));
const overlays = await svc.previewScene({ id: '1' });
assert.strictEqual(overlays.length, 1);

const gpu = new GPUVideoRenderer();
const clip = await gpu.render([], { width: 100, height: 100 });
assert.strictEqual(clip.frames.length, 0);

const editor = new TimelineEditor<string>();
editor.addClip('intro');
assert.deepStrictEqual(editor.getTimeline(), ['intro']);

const grader = new ColorGradingEngine();
grader.apply([[1]], 'warm');

new FaceTrackerService().track({});
new CrowdSimulator().simulate(3);
export360VR([]);
stabilizeCamera([]);
applyWatermark('f', 'wm');
generateSubtitles('hello');
assert.deepStrictEqual(interpolateFrames(['f1', 'f2']), ['f1', 'f1-f2-interp', 'f2']);

React.createElement(BranchingPathsUI, { options: [] });
React.createElement(RenderAnalyticsDashboard, { metrics: [] });
import {
  UnifiedAudioEngine,
  UnifiedVideoEngine,
  AdaptiveLearningEngine,
  PerformanceService,
  VisualRenderer
} from "../src/index.ts";
const engine = UnifiedAudioEngine.shared;
engine.setVolume(1.5);
assert.strictEqual(engine.currentVolume(), 1);
engine.mute();
assert.ok(engine.isMuted());
engine.unmute();
const steps = engine.fadeVolumeTo(0.3, 2);
assert.strictEqual(steps.length, 2);
assert.ok(Math.abs(steps[steps.length - 1] - 0.3) < 0.001);

const vid = UnifiedVideoEngine.shared;
const clip2 = await vid.render(['f1'], { width: 1, height: 1 });
assert.strictEqual(clip2.frames.length, 1);

const learn = AdaptiveLearningEngine.shared;
learn.reset();
learn.recordCompletion('l1');
assert.strictEqual(learn.completionCount('l1'), 1);

const perf = new PerformanceService();
const opt = perf.adjustSettings({ gpuScore: 9, memory: 16 });
assert.strictEqual(opt.resolution, 2160);

const renderer = new VisualRenderer();
const rendered = await renderer.render({ frames: [Buffer.from('f')] });
assert.strictEqual(rendered.frames.length, 1);
assert.strictEqual(rendered.audio.length, 0);
assert.strictEqual(rendered.style, 'default');
const dual = await renderer.renderDual({ frames: [Buffer.from('f')], censorLevel: 2 });
assert.strictEqual(dual.safe.frames[0].toString(), 'f-censored-2');




import { detectCharacters, matchLocationToTemplate, generateStoryboard, detectBookFormat, mergeScenes } from '../src/index.ts';

assert.deepStrictEqual(detectCharacters('Alice meets Bob.'), ['Alice','Bob']);
assert.strictEqual(matchLocationToTemplate('Old Castle Tower'), 'castle');
assert.deepStrictEqual(generateStoryboard(['a','b'])[1], { index: 1, text: 'b' });
assert.strictEqual(detectBookFormat('novel.epub'), 'epub');
assert.strictEqual(detectBookFormat('chapter.docx'), 'docx');
assert.strictEqual(detectBookFormat('notes.md'), 'markdown');
assert.strictEqual(detectBookFormat('image.png'), 'unknown');
assert.deepStrictEqual(mergeScenes(['a','b','c'],1), ['a','b c']);

console.log('New features tests passed');
