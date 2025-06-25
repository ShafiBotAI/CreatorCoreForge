import assert from 'node:assert';
import { TeamSyncManager } from '../services/TeamSyncManager';

const mgr = new TeamSyncManager();
mgr.addMember({ id: 'u1', role: 'Owner' });
assert.strictEqual(mgr.list().length, 1);
mgr.removeMember('u1');
assert.strictEqual(mgr.list().length, 0);
mgr.addMember({ id: 'dev', role: 'Developer' });
assert.strictEqual(mgr.canEdit('dev'), true);
mgr.setRole('dev', 'Viewer');
assert.strictEqual(mgr.canEdit('dev'), false);
mgr.logChange('dev', 'edited file');
assert.strictEqual(mgr.getHistory().length, 1);
console.log('TeamSyncManager tests passed');
