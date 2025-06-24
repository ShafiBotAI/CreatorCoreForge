import fs from 'fs';
import path from 'path';
import { UIElement } from '../models/UIElement';
import { Project } from '../models/Project';
import { CodeGenService, FrontendTarget } from './CodeGenService';

/**
 * BuilderEngine generates simple code bundles for multiple
 * platforms using CodeGenService. It acts as the glue for
 * the drag-and-drop AI app builder and export system.
 */
export class BuilderEngine {
  buildAll(project: Project, layout: UIElement[]): string[] {
    const targets: FrontendTarget[] = ['react', 'vue', 'flutter', 'swiftui', 'html'];
    const codeGen = new CodeGenService();
    const outputDir = path.join('dist', project.id);
    if (!fs.existsSync(outputDir)) {
      fs.mkdirSync(outputDir, { recursive: true });
    }
    const built: string[] = [];
    for (const target of targets) {
      const code = codeGen.generate(layout, target);
      const file = path.join(outputDir, `${target}.txt`);
      fs.writeFileSync(file, code);
      built.push(file);
    }
    return built;
  }
}
