import assert from 'node:assert';
import { AdvancedBuildService } from '../services/AdvancedBuildService';

const svc = new AdvancedBuildService();
assert.strictEqual(svc.initializeBackend('firebase'), 'Firebase backend initialized');
assert.strictEqual(svc.setupCICDPipeline(), true);
assert.strictEqual(svc.enforceNSFWGating(true), true);
assert.strictEqual(svc.exportISO('/tmp'), '/tmp/bundle.iso');
console.log('AdvancedBuildService tests passed');
