import assert from 'node:assert';
import { TestingSuite } from '../services/TestingSuite';

const suite = new TestingSuite();
assert.strictEqual(suite.generate('module').length, 2);
console.log('TestingSuite generate test passed');
