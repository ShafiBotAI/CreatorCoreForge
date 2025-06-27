import assert from 'node:assert';
import { TemplateService } from '../services/TemplateService';
import { BuildEngine } from '../services/BuildEngine';
import { BuilderEngine } from '../services/BuilderEngine';
import { PromptParser } from '../services/PromptParser';
import { CodeGenService } from '../services/CodeGenService';
import { FigmaImporter } from '../services/FigmaImporter';
import { EventBus } from '../services/EventBus';
import { DiffService } from '../services/DiffService';
import { CreativeDNAService } from '../services/CreativeDNAService';
import { DeployService } from '../services/DeployService';
import { UISuggestionService } from '../services/UISuggestionService';
import { WireframeParser } from '../services/WireframeParser';
import { LayoutValidator } from '../services/LayoutValidator';
import { InputHistory } from '../services/InputHistory';
import { LogicVisualizer } from '../services/LogicVisualizer';
import { InputNormalizer } from "../services/InputNormalizer";
import { VoicePromptParser } from '../services/VoicePromptParser';
import { PromptEditor } from '../services/PromptEditor';
import { ThemeService } from '../services/ThemeService';
import { ParseHistory } from '../services/ParseHistory';

(async () => {
  const templates = new TemplateService();
  assert.strictEqual(templates.list().length, 3);

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
  assert(codegen.generateTyped(parsed.layout, 'typescript').includes('export interface'));
  assert(codegen.supportedFrontends().includes('vue'));

  const figma = new FigmaImporter();
  const nodes = figma.parse('{"nodes": [{"name": "Frame1", "type": "FRAME"}]}');
  assert.strictEqual(nodes.length, 1);

  const bus = new EventBus();
  let generated: string | null = null;
  bus.on('generated', e => (generated = e.code));
  bus.emitGenerated('react', '<div />');
  assert.strictEqual(generated, '<div />');


  const bridge = new (await import('../services/PreviewBridge')).PreviewBridge(bus);
  bus.emitParsed(parsed);
  assert(bridge.getCode().includes('<h1>'));

  const diff = new DiffService();
  const diffOutput = diff.diff('a', 'b');
  assert(diffOutput.includes('-a'));

  const sugg = new UISuggestionService();
  assert(sugg.suggestNext([{ type: "header", props: { text: "Login" } }]).length > 0);
  assert(sugg.suggestPatterns("chat").includes("send-button"));

  const wf = new WireframeParser();
  const wire = wf.parse(Buffer.from('abcd'));
  assert.strictEqual(wire[0].type, 'container');

  const validator = new LayoutValidator();
  const fixed = validator.correct('<div><span></div>');
  assert.strictEqual(fixed, '<div><span></span></div>');
  assert(validator.validateGrid([{ type: 'p' }], 'mobile'));

  const dnaSvc = new CreativeDNAService();
  dnaSvc.save({ team: 'X', whiteLabel: true });
  assert.strictEqual(dnaSvc.load().team, 'X');

  const deploy = new DeployService();
  const fs = require('fs');
  const path = require('path');
  const sampleDir = path.join('dist', 'sample');
  fs.mkdirSync(sampleDir, { recursive: true });
  const deployPath = deploy.deploy(sampleDir);
  assert.ok(fs.existsSync(deployPath));

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

  const { ArchitectureDetector } = await import('../services/ArchitectureDetector');
  const arch = new ArchitectureDetector().detect('This is an SPA example');
  assert.strictEqual(arch, 'spa');

  const { AuthScaffolder } = await import('../services/AuthScaffolder');
  const authSnippet = new AuthScaffolder().scaffold('jwt');
  assert(authSnippet.includes('JWT'));
  const { ModuleGenerator } = await import('../services/ModuleGenerator');
  const modules = new ModuleGenerator().generate(parsed.layout);
  assert.strictEqual(modules.length > 0, true);

  const { ErrorHandlingInjector } = await import('../services/ErrorHandlingInjector');
  const wrapped = new ErrorHandlingInjector().inject('doWork()');
  assert(wrapped.includes('try'));

  const { APIGenerator } = await import('../services/APIGenerator');
  assert(new APIGenerator().generate('rest').includes('/api/hello'));

  const { OpenAPIBinder } = await import('../services/OpenAPIBinder');
  const binds = new OpenAPIBinder().bind({ paths: { '/x': { get: {} } } });
  assert(binds[0].includes('/x'));

  const { PlatformConstraintService } = await import('../services/PlatformConstraintService');
  const issues = new PlatformConstraintService().check([{ type: 'camera' } as any]);
  assert(issues.length === 1);

  const { ExportService } = await import('../services/ExportService');
  const annotated = new ExportService().export('console.log("a")', 'annotated');
  assert(annotated.startsWith('// annotated'));

  const { CodeValidator } = await import('../services/CodeValidator');
  const warnings = new CodeValidator().validate('var a = 1');
  assert(warnings.length === 1);

  const { RepoLinkService } = await import('../services/RepoLinkService');
  const repoSvc = new RepoLinkService();
  repoSvc.add('p1', { name: 'origin', url: 'https://example.com', provider: 'github' });
  assert.strictEqual(repoSvc.list('p1').length, 1);

  const { ChangeLogService } = await import('../services/ChangeLogService');
  const cl = new ChangeLogService();
  cl.log('p1', 'init');
  assert(cl.getLog('p1').includes('init'));

  const { APIAccessLogger } = await import('../services/APIAccessLogger');
  const apiLog = new APIAccessLogger();
  apiLog.record('p1', 'u1', '/v1');
  assert.strictEqual(apiLog.list('p1').length, 1);

  const { AICopilotChat } = await import('../services/AICopilotChat');
  const chat = new AICopilotChat();
  assert(chat.ask('why').includes('approach'));

  const { TestCaseGenerator } = await import('../services/TestCaseGenerator');
  const tcg = new TestCaseGenerator();
  assert.strictEqual(tcg.generate('foo').length, 2);

  const { DocGenerator } = await import('../services/DocGenerator');
  const docGen = new DocGenerator();
  docGen.generate('Sample', 'Example');


  console.log('CoreForgeBuild tests passed');
  require('./collaboration.test');
  require("./autoupdater.test");
  require('./pluginmanager.test');
  require('./advanced.test');
  require('./formbuilder.test');
  require('./localization.test');
  require('./formexport.test');
})();
