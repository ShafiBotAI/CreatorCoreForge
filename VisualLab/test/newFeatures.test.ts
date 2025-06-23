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
  RenderAnalyticsDashboard
} from '../src/index.ts';
import React from 'react';
import assert from 'node:assert';

const svc = new ARService();
await svc.previewScene({ id: '1' });

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

React.createElement(BranchingPathsUI, { options: [] });
React.createElement(RenderAnalyticsDashboard, { metrics: [] });
import {
  UnifiedAudioEngine,
  UnifiedVideoEngine,
  AdaptiveLearningEngine,
  PerformanceService
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


console.log('New features tests passed');

