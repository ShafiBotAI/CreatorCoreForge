import { TemplateService } from '../services/TemplateService';
import { PromptParser } from '../services/PromptParser';
import { CodeGenService } from '../services/CodeGenService';
import { FigmaImporter } from '../services/FigmaImporter';
import { EventBus } from '../services/EventBus';
import { DiffService } from '../services/DiffService';
import { BuildEngine } from '../services/BuildEngine';
import { BuilderEngine } from '../services/BuilderEngine';
import { CreativeDNAService } from '../services/CreativeDNAService';
import { DeployService } from '../services/DeployService';
import { UISuggestionService } from '../services/UISuggestionService';
import { WireframeParser } from '../services/WireframeParser';
import { LayoutValidator } from '../services/LayoutValidator';
import fs from 'fs';
import assert from 'node:assert';

(async () => {
  const svc = new TemplateService();
  assert.strictEqual(svc.list().length, 2);


process.env.NODE_ENV = 'test';
const engine = new BuildEngine('/tmp');
assert.ok(engine.build('web').includes('dist'));

const parser = new PromptParser();
const result = parser.parse('# Login\n- Email\n- Password\nlogin -> dashboard -> settings');
assert.strictEqual(result.language, 'en');
assert.strictEqual(result.layout.length, 3);
assert.strictEqual(result.flows.length, 1);
assert.deepStrictEqual(result.flows[0], ['login', 'dashboard', 'settings']);

const codegen = new CodeGenService();
const reactCode = codegen.generate(result.layout, 'react');
assert(reactCode.includes('<ul>'));

const figma = new FigmaImporter();
const nodes = figma.parse('{"nodes": [{"name": "Frame1", "type": "FRAME"}]}');
assert.strictEqual(nodes.length, 1);

const bus = new EventBus();
let generated: string | null = null;
bus.on('generated', e => (generated = e.code));
bus.emitGenerated('react', '<div />');
assert.strictEqual(generated, '<div />');
=======
  process.env.NODE_ENV = 'test';
  const engine = new BuilderEngine();
  assert.ok(engine.buildAll({ id: 'a', name: 'A', platform: 'web' }, []).length > 0);

  const parser = new PromptParser();
  const result = parser.parse('# Login\n- Email\n- Password\nlogin -> dashboard -> settings');
  assert.strictEqual(result.language, 'en');
  assert.strictEqual(result.flows[0][0], 'login');

  const nl = parser.parse('A login screen with email and password fields');
  assert(nl.layout.some(el => el.type === 'header'));

  const codegen = new CodeGenService();
  const reactCode = codegen.generate(result.layout, 'react');
  assert(reactCode.includes('<ul>'));

  const figma = new FigmaImporter();
  const sketchNodes = figma.parse({ layers: [{ name: 'Layer', _class: 'Artboard' }] });
  assert.strictEqual(sketchNodes.length, 1);

  const bus = new EventBus();
  let generated: string | null = null;
  bus.on('generated', e => (generated = e.code));
  bus.emitGenerated('react', '<div />');
  assert.strictEqual(generated, '<div />');

  const diff = new DiffService();
  const diffOutput = diff.diff('a', 'b');
  assert(diffOutput.includes('-a'));


  const sugg = new UISuggestionService();
  assert(sugg.suggestNext([{ type: 'header', props: { text: 'Login' } }]).length > 0);

  const wf = new WireframeParser();
  const wire = wf.parse(Buffer.from('abcd'));
  assert.strictEqual(wire[0].type, 'container');


const builder = new BuilderEngine();
const built = builder.buildAll({ id: 'sample', name: 'Sample', platform: 'web' }, []);
assert.strictEqual(built.length, 5);
assert(built.every(f => fs.existsSync(f)));
=======
  const validator = new LayoutValidator();
  const fixed = validator.correct('<div><span></div>');
  assert.strictEqual(fixed, '<div><span></span></div>');


  const dnaSvc = new CreativeDNAService();
  dnaSvc.save({ team: 'X', whiteLabel: true });
  const dna = dnaSvc.load();
  assert.strictEqual(dna.team, 'X');

  const deploy = new DeployService();
  assert.strictEqual(deploy.deploy('dist/sample'), 'dist/sample');


console.log('CoreForgeBuild tests passed');

require('./collaboration.test');
=======
  console.log('CoreForgeBuild tests passed');
  require('./collaboration.test');
})();

