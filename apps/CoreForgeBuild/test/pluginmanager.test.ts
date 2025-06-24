import assert from 'node:assert';
import { PluginManager } from '../services/PluginManager';
import { PluginManifest } from '../models/PluginManifest';
import fs from 'fs';

const manager = new PluginManager();
const manifest: PluginManifest = {
  name: 'Demo',
  version: '1.0',
  inputs: [],
  outputs: [],
  permissions: []
};

async function run() {
  manager.dragAndDropInstall(manifest);
  assert.strictEqual(manager.validate(manifest).length, 0);
  manager.recordUsage('Demo');
  assert.strictEqual(manager.usageAnalytics('Demo'), 1);
  manager.addRating('Demo', 5, 'Great');
  assert.strictEqual(manager.averageRating('Demo'), 5);
  assert.ok(manager.preview(manifest).includes('Demo'));
  assert.ok(manager.dependencyGraph().includes('Demo'));
  assert.deepStrictEqual(manager.copilotDebug('eval("1")').length > 0, true);
  fs.mkdirSync('/tmp/demo', { recursive: true });
  fs.writeFileSync('/tmp/demo/index.ts', '');
  manager.uploadCustomPlugin('/tmp/demo', manifest);
  const out = await manager.exportPlugin('Demo', '/tmp');
  assert.ok(out && fs.existsSync(out));
  console.log('PluginManager tests passed');
}

run();
