export interface RepoInfo {
  name: string;
  url: string;
  provider: 'github' | 'bitbucket';
}

export class RepoLinkService {
  private repos = new Map<string, RepoInfo[]>();

  add(projectId: string, info: RepoInfo) {
    const list = this.repos.get(projectId) || [];
    list.push(info);
    this.repos.set(projectId, list);
  }

  list(projectId: string): RepoInfo[] {
    return [...(this.repos.get(projectId) || [])];
  }

  sync(projectId: string, name: string) {
    const repo = (this.repos.get(projectId) || []).find(r => r.name === name);
    if (!repo) return;
    const exec = require('child_process').execSync;
    try {
      exec(`git remote add ${name} ${repo.url}`, { stdio: 'ignore' });
      exec(`git pull ${name} main`, { stdio: 'inherit' });
    } catch {
      /* ignore errors for placeholder logic */
    }
  }
}
