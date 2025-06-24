import { TemplateService } from '../services/TemplateService';
import { PromptParser } from '../services/PromptParser';
import { CodeGenService } from '../services/CodeGenService';
import { FigmaImporter } from '../services/FigmaImporter';
import { EventBus } from '../services/EventBus';
import { DiffService } from '../services/DiffService';
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

// additional service tests
const figma = new FigmaImporter();
const nodes = figma.parse('{"nodes": [{"name": "Frame1", "type": "FRAME"}]}');
assert.strictEqual(nodes.length, 1);

const bus = new EventBus();
let generated: string | null = null;
bus.on('generated', (e) => (generated = e.code));
bus.emitGenerated('react', '<div />');
assert.strictEqual(generated, '<div />');

const diff = new DiffService();
const diffOutput = diff.diff('a', 'b');
assert(diffOutput.includes('-a') && diffOutput.includes('+b'));

const expressCode = codegen.generate([], 'express', 'minimal');
assert(expressCode.includes('express'));

console.log('CoreForgeBuild tests passed');

