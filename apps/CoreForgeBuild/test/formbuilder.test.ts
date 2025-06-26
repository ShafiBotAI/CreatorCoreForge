import assert from 'node:assert';
import { parseClipboard } from '../services/ClipboardFormParser';
import { formBlueprintLibrary } from '../services/FormBlueprintLibrary';
import { analyticsService } from '../services/AnalyticsService';

const fields = parseClipboard('Name:text\nEmail:email, required');
assert.strictEqual(fields.length, 2);

formBlueprintLibrary.save({ id: 'demo', fields });
assert.strictEqual(formBlueprintLibrary.get('demo')?.fields.length, 2);

analyticsService.recordSubmit(false);
analyticsService.recordSubmit(true);
assert.ok(analyticsService.stats().abandonRate > 0);

console.log('formbuilder tests passed');
