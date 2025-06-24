import { TemplateService } from '../services/TemplateService';
import assert from 'node:assert';

const svc = new TemplateService();
assert.strictEqual(svc.list().length, 2);

// run BuildEngine smoke test
import { BuildEngine } from '../services/BuildEngine';
process.env.NODE_ENV = 'test';
const engine = new BuildEngine('/tmp');
assert.ok(engine.build('web').includes('dist'));



console.log('CoreForgeBuild tests passed');
