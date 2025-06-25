export interface Collaborator {
  id: string;
  role: string;
}

export class TeamSyncManager {
  private members = new Map<string, Collaborator>();

  private history: { user: string; message: string }[] = [];
=======

  addMember(user: Collaborator) {
    this.members.set(user.id, user);
  }

  removeMember(id: string) {
    this.members.delete(id);
  }


  setRole(id: string, role: string) {
    const m = this.members.get(id);
    if (m) {
      m.role = role;
      this.members.set(id, m);
    }
  }

  canEdit(id: string): boolean {
    const role = this.members.get(id)?.role;
    return role !== 'Viewer' && role !== 'Guest';
  }

  logChange(userId: string, message: string) {
    this.history.push({ user: userId, message });
  }

  getHistory() {
    return this.history;
  }

  list(): Collaborator[] {
    return Array.from(this.members.values());
  }
}
