export type Role = 'Owner' | 'Admin' | 'Developer' | 'Viewer';

export interface Collaborator {
  id: string;
  name: string;
  role: Role;
}
