export interface Comment {
  id: string;
  authorId: string;
  targetId: string; // component or code block identifier
  parentId?: string;
  message: string;
  createdAt: Date;
}
