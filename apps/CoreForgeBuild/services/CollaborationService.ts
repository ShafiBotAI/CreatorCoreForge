import { Collaborator, Role } from '../models/Collaborator';
import { Version } from '../models/Version';
import { Comment } from '../models/Comment';
import { diffLines } from 'diff';

interface ProjectData {
  collaborators: Collaborator[];
  versions: Version<any>[];
  comments: Comment[];
  lastSnapshot?: any;
}

interface InviteData {
  email: string;
  role: Role;
  expiresAt?: Date;
}

interface AuditEntry {
  userId: string;
  action: string;
  timestamp: Date;
}

interface Workspace {
  type: 'personal' | 'team' | 'client';
  slug: string;
  logo?: string;
  theme?: string;
  public: boolean;
}

/**
 * In-memory collaboration service to handle basic Phase 7 features:
 * roles, version history, comments, and simple diff generation.
 */
export class CollaborationService {
  private projects = new Map<string, ProjectData>();
  private invites = new Map<string, InviteData[]>();
  private presence = new Map<string, Set<string>>();
  private audit = new Map<string, AuditEntry[]>();
  private permissions = new Map<string, Map<string, Role>>();
  private workspaceMode = new Map<string, Workspace>();
  private lastActivity = new Map<string, Date>();
  private archived = new Set<string>();
  private deployPerms = new Map<string, Map<string, Role>>();

  private data(projectId: string): ProjectData {
    if (!this.projects.has(projectId)) {
      this.projects.set(projectId, { collaborators: [], versions: [], comments: [] });
    }
    return this.projects.get(projectId)!;
  }

  addCollaborator(projectId: string, collaborator: Collaborator) {
    const d = this.data(projectId);
    d.collaborators.push(collaborator);
  }

  listCollaborators(projectId: string): Collaborator[] {
    return [...this.data(projectId).collaborators];
  }

  addVersion<T>(projectId: string, snapshot: T, userId: string, message: string): Version<T> {
    const d = this.data(projectId);
    const previous = d.lastSnapshot;
    const diff = previous ? diffLines(JSON.stringify(previous, null, 2), JSON.stringify(snapshot, null, 2)) : [];
    const diffText = diff.map(part => `${part.added ? '+' : part.removed ? '-' : ' '}${part.value}`).join('');
    const version: Version<T> = {
      id: `${d.versions.length + 1}`,
      userId,
      createdAt: new Date(),
      message,
      snapshot,
      diff: diffText
    };
    d.versions.push(version);
    d.lastSnapshot = snapshot;
    return version;
  }

  getVersions(projectId: string): Version[] {
    return [...this.data(projectId).versions];
  }

  addComment(projectId: string, comment: Comment) {
    const d = this.data(projectId);
    d.comments.push(comment);
  }

  listComments(projectId: string, targetId?: string): Comment[] {
    const comments = this.data(projectId).comments;
    return targetId ? comments.filter(c => c.targetId === targetId) : [...comments];
  }

  invite(projectId: string, email: string, role: Role, expiresAt?: Date) {
    const arr = this.invites.get(projectId) || [];
    arr.push({ email, role, expiresAt });
    this.invites.set(projectId, arr);
  }

  acceptInvite(projectId: string, email: string, userId: string, name: string): boolean {
    const arr = this.invites.get(projectId) || [];
    const idx = arr.findIndex(i => i.email === email && (!i.expiresAt || i.expiresAt > new Date()));
    if (idx === -1) return false;
    this.addCollaborator(projectId, { id: userId, name, role: arr[idx].role });
    arr.splice(idx, 1);
    this.invites.set(projectId, arr);
    return true;
  }

  enter(projectId: string, userId: string) {
    const set = this.presence.get(projectId) || new Set<string>();
    set.add(userId);
    this.presence.set(projectId, set);
  }

  leave(projectId: string, userId: string) {
    const set = this.presence.get(projectId);
    set?.delete(userId);
  }

  logAction(projectId: string, userId: string, action: string) {
    const arr = this.audit.get(projectId) || [];
    arr.push({ userId, action, timestamp: new Date() });
    this.audit.set(projectId, arr);
    this.lastActivity.set(projectId, new Date());
  }

  setModulePermission(projectId: string, module: string, role: Role) {
    let map = this.permissions.get(projectId);
    if (!map) {
      map = new Map();
      this.permissions.set(projectId, map);
    }
    map.set(module, role);
  }

  getModulePermission(projectId: string, module: string): Role | undefined {
    return this.permissions.get(projectId)?.get(module);
  }

  restoreVersion<T>(projectId: string, id: string): T | null {
    const v = this.data(projectId).versions.find(v => v.id === id);
    if (!v) return null;
    this.data(projectId).lastSnapshot = v.snapshot;
    return v.snapshot as T;
  }

  createCheckpoint(projectId: string, versionId: string, label: string) {
    const v = this.data(projectId).versions.find(v => v.id === versionId);
    if (v) v.message = label;
  }

  togglePublic(projectId: string, isPublic: boolean) {
    const ws = this.workspaceMode.get(projectId) || { type: 'personal', slug: projectId, public: isPublic };
    ws.public = isPublic;
    this.workspaceMode.set(projectId, ws);
  }

  setWorkspace(projectId: string, ws: Workspace) {
    this.workspaceMode.set(projectId, ws);
  }

  archiveInactive(days: number) {
    const limit = Date.now() - days * 24 * 60 * 60 * 1000;
    for (const [id, last] of this.lastActivity.entries()) {
      if (last.getTime() < limit) this.archived.add(id);
    }
  }

  isArchived(projectId: string): boolean {
    return this.archived.has(projectId);
  }

  recordDeploymentPermission(projectId: string, userId: string, role: Role) {
    let map = this.deployPerms.get(projectId);
    if (!map) {
      map = new Map();
      this.deployPerms.set(projectId, map);
    }
    map.set(userId, role);
  }
}
