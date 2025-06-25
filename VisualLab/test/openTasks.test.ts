import {
  RenderSuggestionService,
  CreditEngine,
  UnlockManager,
  SceneToggleService,
  ContentFilter,
  censorLayer,
  censorRegions,
  fuseScenes,
  applyHallucinogenicFilter,
  applySurrealism,
  exportVideoMP4,
  generateCoverArt,
  addMetadata,
  UploadManager,
  UploadStatusDashboard,
  StylePicker
} from '../src/index.ts';
import React from 'react';
import assert from 'node:assert';

const suggest = new RenderSuggestionService<string>();
suggest.recordPath('A');
assert.strictEqual(suggest.suggest(['A','B']), 'B');

const credits = new CreditEngine();
assert.ok(credits.canConvert('u','Pro'));
credits.recordConversion('u','Pro');
assert.ok(!credits.canConvert('u','Pro'));
credits.buyCredit('u');
assert.ok(credits.canConvert('u','Pro'));

const unlock = new UnlockManager();
unlock.applyCode('u','CREATOR');
assert.ok(unlock.isEnabled('u','creatorTab'));

const toggle = new SceneToggleService();
toggle.enable('erotic');
assert.ok(toggle.isEnabled('erotic'));

const filter = new ContentFilter();
filter.verify('u');
assert.ok(filter.canPreview('u'));
assert.strictEqual(censorLayer('frame',1),'frame-censored-1');
assert.strictEqual(
  censorRegions('frame', [{ region: 'chest', level: 2 }]),
  'frame-chest-blur2'
);

assert.deepStrictEqual(fuseScenes(['a'],['b']), ['a|b']);
assert.deepStrictEqual(applyHallucinogenicFilter(['f']), ['f-trippy']);
assert.deepStrictEqual(applySurrealism(['f'], true), ['f-surreal']);

const video = exportVideoMP4([Buffer.from('f')]);
assert.ok(video.slice(0,3).toString() === 'MP4');
assert.strictEqual(generateCoverArt('t'), 'cover-t');
addMetadata(video, {title:'t', author:'a'});

const manager = new UploadManager();
manager.upload(Buffer.from('v'), ['p1','p2']);
manager.enableSecondPlatform();
manager.upload(Buffer.from('v'), ['p1','p2']);
const logs = manager.getLogs();
React.createElement(UploadStatusDashboard, { logs });
React.createElement(StylePicker, { value:'anime', onChange: ()=>{} });
console.log('open tasks tests passed');
