import assert from 'node:assert';
import { TeamSyncManager } from '../services/TeamSyncManager';

const mgr = new TeamSyncManager();
mgr.addMember({ id: 'u1', role: 'Owner' });
assert.strictEqual(mgr.list().length, 1);
mgr.removeMember('u1');
assert.strictEqual(mgr.list().length, 0);
console.log('TeamSyncManager tests passed');
