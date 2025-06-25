export type Role =
  | 'Owner'
  | 'Admin'
  | 'Developer'
  | 'Reviewer'
  | 'Viewer'
  | 'Guest';

export interface Collaborator {
  id: string;
  name: string;
  role: Role;
}
