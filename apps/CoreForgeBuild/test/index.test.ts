import { TemplateService } from '../services/TemplateService';
import assert from 'node:assert';

const svc = new TemplateService();
assert.strictEqual(svc.list().length, 2);



console.log('CoreForgeBuild tests passed');

// run additional tests
require('./collaboration.test');
