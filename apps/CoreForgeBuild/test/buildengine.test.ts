import { BuildEngine } from '../services/BuildEngine';
import assert from 'node:assert';

const engine = new BuildEngine('/tmp');
const out = engine.build('web');
assert.ok(out.includes('dist'));
console.log('BuildEngine test passed');
