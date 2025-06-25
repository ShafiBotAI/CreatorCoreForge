import assert from 'node:assert';
import { registerHotkeys } from '../components/AICopilot';

const calls: any[] = [];
const target = {
  addEventListener: (_: string, cb: (e: any) => void) => {
    calls.push(cb);
  }
};
let asked: string | null = null;
registerHotkeys(target as any, { h: 'help' }, q => {
  asked = q;
});
// simulate keydown
calls[0]({ key: 'h' });
assert.strictEqual(asked, 'help');
console.log('AICopilot hotkey test passed');
