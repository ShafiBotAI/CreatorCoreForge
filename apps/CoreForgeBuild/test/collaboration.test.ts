import { CollaborationService } from '../services/CollaborationService';
import { AICopilotService } from '../services/AICopilotService';
import { SecurityScanner } from '../services/SecurityScanner';
import assert from 'node:assert';

const collab = new CollaborationService();
collab.addCollaborator('p1', { id: 'u1', name: 'Alice', role: 'Owner' });
assert.strictEqual(collab.listCollaborators('p1').length, 1);
collab.invite('p1', 'bob@example.com', 'Developer');
assert.ok(collab.acceptInvite('p1', 'bob@example.com', 'u2', 'Bob'));
collab.enter('p1', 'u2');
collab.logAction('p1', 'u2', 'edit');
collab.setModulePermission('p1', 'ui', 'Developer');
assert.strictEqual(collab.getModulePermission('p1', 'ui'), 'Developer');
collab.recordDeploymentPermission('p1', 'u2', 'Developer');
collab.archiveInactive(-1);
assert.ok(collab.isArchived('p1'));

const v = collab.addVersion('p1', { a: 1 }, 'u1', 'init');
assert.strictEqual(collab.getVersions('p1')[0].id, v.id);

collab.addComment('p1', { id: 'c1', authorId: 'u1', targetId: 't1', message: 'hi', createdAt: new Date() });
assert.strictEqual(collab.listComments('p1').length, 1);

const ai = new AICopilotService();
assert.ok(ai.suggestRefactor('eval("alert(1)")').length > 0);

const sec = new SecurityScanner();
assert.ok(sec.scan('http://example.com').length > 0);

console.log('Collaboration tests passed');
