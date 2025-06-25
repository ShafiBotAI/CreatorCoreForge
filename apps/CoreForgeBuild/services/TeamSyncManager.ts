export interface Collaborator {
  id: string;
  role: string;
}

export class TeamSyncManager {
  private members = new Map<string, Collaborator>();

  addMember(user: Collaborator) {
    this.members.set(user.id, user);
  }

  removeMember(id: string) {
    this.members.delete(id);
  }

  list(): Collaborator[] {
    return Array.from(this.members.values());
  }
}
