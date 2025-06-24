import assert from 'node:assert';
import fs from 'fs';
import { TemplateService } from '../services/TemplateService';
import { BuildEngine } from '../services/BuildEngine';
import { BuilderEngine } from '../services/BuilderEngine';
import { PromptParser } from '../services/PromptParser';
import { CodeGenService } from '../services/CodeGenService';
import { FigmaImporter } from '../services/FigmaImporter';
import { EventBus } from '../services/EventBus';
import { DiffService } from '../services/DiffService';

import { BuilderEngine } from '../services/BuilderEngine';
import { CreativeDNAService } from '../services/CreativeDNAService';
import { DeployService } from '../services/DeployService';

import { UISuggestionService } from '../services/UISuggestionService';
import { WireframeParser } from '../services/WireframeParser';
import { LayoutValidator } from '../services/LayoutValidator';
import { CreativeDNAService } from '../services/CreativeDNAService';
import { DeployService } from '../services/DeployService';
import { InputNormalizer } from '../services/InputNormalizer';
import { InputHistory } from '../services/InputHistory';
import { LogicVisualizer } from '../services/LogicVisualizer';

(async () => {

  const templates = new TemplateService();
  assert.strictEqual(templates.list().length, 2);

  process.env.NODE_ENV = 'test';
  const build = new BuildEngine('/tmp');
  assert.ok(build.build('web').includes('dist'));

  const builder = new BuilderEngine();
  assert.ok(builder.buildAll({ id: 'a', name: 'A', platform: 'web' }, []).length > 0);

  const parser = new PromptParser();
  const parsed = parser.parse('# Login\n- Email\n- Password\nlogin -> dashboard -> settings');
  assert.strictEqual(parsed.language, 'en');
  assert.strictEqual(parsed.flows[0][0], 'login');
  assert.ok(parsed.flowTags.includes('dashboard'));

  const codegen = new CodeGenService();
  const reactCode = codegen.generate(parsed.layout, 'react');
  assert(reactCode.includes('<ul>'));

  const figma = new FigmaImporter();
  const nodes = figma.parse('{"nodes": [{"name": "Frame1", "type": "FRAME"}]}');
  assert.strictEqual(nodes.length, 1);

  const bus = new EventBus();
  let generated: string | null = null;
  bus.on('generated', e => (generated = e.code));
  bus.emitGenerated('react', '<div />');
  assert.strictEqual(generated, '<div />');

  const diff = new DiffService();

  const diffOutput = diff.diff('a', 'b');
  assert(diffOutput.includes('-a'));
=======
  assert(diff.diff('a', 'b').includes('-a'));


  const sugg = new UISuggestionService();
  assert(sugg.suggestNext([{ type: 'header', props: { text: 'Login' } }]).length > 0);
  assert(sugg.suggestPatterns('chat').includes('send-button'));


  const wf = new WireframeParser();
  const wire = wf.parse(Buffer.from('abcd'));
  assert.strictEqual(wire[0].type, 'container');

  const validator = new LayoutValidator();
  const fixed = validator.correct('<div><span></div>');
  assert.strictEqual(fixed, '<div><span></span></div>');
  const wireframe = new WireframeParser();
  assert.strictEqual(wireframe.parse(Buffer.from('abcd'))[0].type, 'container');

  const validator = new LayoutValidator();
  assert.strictEqual(validator.correct('<div><span></div>'), '<div><span></span></div>');


  const dnaSvc = new CreativeDNAService();
  dnaSvc.save({ team: 'X', whiteLabel: true });
  assert.strictEqual(dnaSvc.load().team, 'X');

  const deploy = new DeployService();
  assert.strictEqual(deploy.deploy('dist/sample'), 'dist/sample');

=======
  const history = new InputHistory();
  history.add('First');
  assert.strictEqual(history.list().length, 1);

  const normalizer = new InputNormalizer();
  assert(normalizer.toASUIM('Simple text').length > 0);
  assert(normalizer.toASUIM(Buffer.from('abc')).length > 0);

  const visualizer = new LogicVisualizer();
  const ascii = visualizer.toASCII([{ type: 'header', props: { text: 'Title' } }]);
  assert(ascii.includes('header'));


  console.log('CoreForgeBuild tests passed');
  require('./collaboration.test');
})();
