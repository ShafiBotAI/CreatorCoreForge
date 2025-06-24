import { TemplateService } from '../services/TemplateService';
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
import fs from 'fs';
import assert from 'node:assert';
  const engine = new BuilderEngine();
  assert.ok(engine.buildAll({ id: 'a', name: 'A', platform: 'web' }, []).length > 0);

  const result = parser.parse('# Login\n- Email\n- Password\nlogin -> dashboard -> settings');
  assert.strictEqual(result.language, 'en');
  assert.strictEqual(result.flows[0][0], 'login');

  const nl = parser.parse('A login screen with email and password fields');
  assert(nl.layout.some(el => el.type === 'header'));
  const reactCode = codegen.generate(result.layout, 'react');
  const sketchNodes = figma.parse({ layers: [{ name: 'Layer', _class: 'Artboard' }] });
  assert.strictEqual(sketchNodes.length, 1);
  const dna = dnaSvc.load();
  assert.strictEqual(dna.team, 'X');

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

  const history = new InputHistory();
  history.add('First', parsed);
  assert.strictEqual(history.list().length, 1);

  const normalizer = new InputNormalizer();
  assert(normalizer.toASUIM('Simple text').length > 0);
  assert(normalizer.toASUIM(Buffer.from('abc')).length > 0);

  // multilingual prompt parsing
  const parsedEs = parser.parse('hola inicio');
  assert.strictEqual(parsedEs.language, 'es');

  // pattern recognition
  const patternParsed = parser.parse('Onboarding flow with tabbed menu');
  assert(patternParsed.patterns?.includes('onboarding'));
  assert(patternParsed.patterns?.includes('tabbed-navigation'));

  const voiceParser = new VoicePromptParser();
  const voiceResult = voiceParser.parseVoice(Buffer.from('login -> dashboard'));
  assert(voiceResult.flows.length > 0);

  const editor = new PromptEditor();
  const corrected = editor.applyCorrection([{ type: 'paragraph', props: { text: 'old' } }], { index: 0, text: 'new' });
  assert.strictEqual(corrected[0].props?.text, 'new');

  const themeSvc = new ThemeService();
  assert(themeSvc.suggestThemes('Dark Brand')[0] === 'dark');

  const parseHistory = new ParseHistory();
  parseHistory.add(parsed);
  assert.strictEqual(parseHistory.all().length, 1);

  const visualizer = new LogicVisualizer();
  const ascii = visualizer.toASCII([{ type: 'header', props: { text: 'Title' } }]);
  assert(ascii.includes('header'));


  console.log('CoreForgeBuild tests passed');
  require('./collaboration.test');
})();
