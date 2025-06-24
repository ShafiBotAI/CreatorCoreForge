import assert from 'node:assert';
import { PluginManager } from '../services/PluginManager';
import { PluginManifest } from '../models/PluginManifest';

const manager = new PluginManager();
const manifest: PluginManifest = {
  name: 'Demo',
  version: '1.0',
  inputs: [],
  outputs: [],
  permissions: []
};

manager.dragAndDropInstall(manifest);
assert.strictEqual(manager.validate(manifest).length, 0);
manager.recordUsage('Demo');
assert.strictEqual(manager.usageAnalytics('Demo'), 1);
manager.addRating('Demo', 5, 'Great');
assert.strictEqual(manager.averageRating('Demo'), 5);
assert.ok(manager.preview(manifest).includes('Demo'));
assert.ok(manager.dependencyGraph().includes('Demo'));
assert.deepStrictEqual(manager.copilotDebug('eval("1")').length > 0, true);
console.log('PluginManager tests passed');
