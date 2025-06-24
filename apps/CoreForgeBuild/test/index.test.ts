import { TemplateService } from '../services/TemplateService';
import { PromptParser } from '../services/PromptParser';
import { CodeGenService } from '../services/CodeGenService';
import assert from 'node:assert';

const svc = new TemplateService();
assert.strictEqual(svc.list().length, 2);

const parser = new PromptParser();
const result = parser.parse('# Login\n- Email\n- Password');
assert.strictEqual(result.language, 'en');
assert.strictEqual(result.layout.length, 2);

const codegen = new CodeGenService();
const reactCode = codegen.generate(result.layout, 'react');
assert(reactCode.includes('<ul>'));

console.log('CoreForgeBuild tests passed');

