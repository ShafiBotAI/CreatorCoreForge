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

/**
 * In-memory collaboration service to handle basic Phase 7 features:
 * roles, version history, comments, and simple diff generation.
 */
export class CollaborationService {
  private projects = new Map<string, ProjectData>();

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
}
