import fs from 'fs';
import { execSync } from 'child_process';
import path from 'path';
import { PluginManifest } from '../models/PluginManifest';
import { PluginScope } from '../models/PluginScope';
import { AICopilotService } from './AICopilotService';
import { exportPluginDir } from './PluginExporter';

export interface Rating {
  userId: string;
  rating: number;
  review?: string;
}

/**
 * PluginManager provides very light weight handling of custom
 * plugins for CoreForge Build. It is not a full marketplace
 * implementation but supports the basic Phase 4 tasks.
 */
export class PluginManager {
  private plugins = new Map<string, PluginManifest>();
  private scopes = new Map<string, PluginScope>();
  private usage = new Map<string, number>();
  private ratings = new Map<string, Rating[]>();

  /** Install plugin via drag-and-drop from marketplace. */
  dragAndDropInstall(manifest: PluginManifest) {
    this.plugins.set(manifest.name, manifest);
  }

  /** Upload a custom plugin module with accompanying manifest. */
  uploadCustomPlugin(dir: string, manifest: PluginManifest) {
    const dest = path.join('plugins', manifest.name);
    fs.mkdirSync(dest, { recursive: true });
    fs.cpSync(dir, dest, { recursive: true });
    this.plugins.set(manifest.name, manifest);
  }

  /** Validate basic manifest fields and simple lifecycle hooks. */
  validate(manifest: PluginManifest): string[] {
    const issues: string[] = [];
    if (!manifest.name) issues.push('name required');
    if (!manifest.version) issues.push('version required');
    if (manifest.premium && manifest.price == null) {
      issues.push('price required for premium plugin');
    }
    return issues;
  }

  /** Create simple docs from code annotations. */
  generateDocs(code: string): string {
    return code
      .split(/\r?\n/)
      .filter((l) => l.trim().startsWith('//'))
      .map((l) => l.replace('//', '').trim())
      .join('\n');
  }

  /** Return a basic preview string for the plugin. */
  preview(manifest: PluginManifest): string {
    return `<div data-plugin="${manifest.name}">${manifest.name}</div>`;
  }

  /** Import external package using system package manager. */
  importPackage(pkg: string, manager: 'npm' | 'pip' | 'swiftpm') {
    try {
      if (process.env.NODE_ENV !== 'test') {
        if (manager === 'npm') {
          execSync(`npm install ${pkg}`, { stdio: 'ignore' });
        } else if (manager === 'pip') {
          execSync(`pip install ${pkg}`, { stdio: 'ignore' });
        }
      }
    } catch {
      /* ignore errors in demo environment */
    }
  }

  /** Record plugin usage for analytics. */
  recordUsage(name: string) {
    this.usage.set(name, (this.usage.get(name) || 0) + 1);
  }

  /** Simple dependency conflict detection. */
  detectConflicts(manifest: PluginManifest): string[] {
    const conflicts: string[] = [];
    if (this.plugins.has(manifest.name) && this.plugins.get(manifest.name)?.version !== manifest.version) {
      conflicts.push('version mismatch with installed plugin');
    }
    return conflicts;
  }

  setScope(name: string, scope: PluginScope) {
    this.scopes.set(name, scope);
  }

  addRating(name: string, rating: number, review?: string, userId = 'anon') {
    const arr = this.ratings.get(name) || [];
    arr.push({ userId, rating: Math.max(1, Math.min(5, rating)), review });
    this.ratings.set(name, arr);
  }

  averageRating(name: string): number {
    const arr = this.ratings.get(name) || [];
    if (arr.length === 0) return 0;
    return arr.reduce((a, b) => a + b.rating, 0) / arr.length;
  }

  /** Import plugins from GitHub using pull_plugins.py */
  importFromGitHub(repo: string, dest: string, branch = 'master') {
    if (process.env.NODE_ENV === 'test') return;
    try {
      execSync(`python3 pull_plugins.py ${repo} ${dest} ${branch}`, { cwd: path.resolve(__dirname, '..') });
    } catch {
      /* ignore */
    }
  }

  installLocal(pathOrDir: string, manifest: PluginManifest) {
    fs.mkdirSync('plugins', { recursive: true });
    fs.cpSync(pathOrDir, path.join('plugins', manifest.name), { recursive: true });
    this.plugins.set(manifest.name, manifest);
  }

  installCloud(url: string, manifest: PluginManifest) {
    this.plugins.set(manifest.name, manifest);
    // a real implementation would fetch from cloud URL
  }

  sandboxTest(manifest: PluginManifest): boolean {
    return this.validate(manifest).length === 0;
  }

  dependencyGraph(): string {
    return Array.from(this.plugins.values())
      .map((m) => `${m.name}->${(m.dependencies || []).join(',')}`)
      .join('\n');
  }

  usageAnalytics(name: string): number {
    return this.usage.get(name) || 0;
  }

  purchasePlugin(name: string, userId: string): boolean {
    const plugin = this.plugins.get(name);
    if (!plugin) return false;
    if (plugin.premium) {
      // In a real system we would charge the user here
      return true;
    }
    return true;
  }

  copilotDebug(code: string): string[] {
    const copilot = new AICopilotService();
    return copilot.suggestRefactor(code);
  }

  setAccessRole(name: string, userId: string, role: string) {
    // Placeholder for access control; store scope per plugin
    this.scopes.set(`${name}:${userId}`, role as PluginScope);
  }

  autoUpdate(name: string, repo: string) {
    const plugin = this.plugins.get(name);
    if (!plugin) return;
    const newVersion = (parseFloat(plugin.version) + 0.1).toFixed(1);
    plugin.version = newVersion;
    this.plugins.set(name, plugin);
  }

  editSource(name: string, code: string) {
    const dir = path.join('plugins', name);
    fs.mkdirSync(dir, { recursive: true });
    fs.writeFileSync(path.join(dir, 'index.ts'), code);
  }

  exportPlugin(name: string, outDir: string): Promise<string | null> {
    const dir = path.join('plugins', name);
    if (!fs.existsSync(dir)) return Promise.resolve(null);
    return exportPluginDir(dir, outDir);
  }
}
