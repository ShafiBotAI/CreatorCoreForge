export interface Comment {
  id: string;
  authorId: string;
  targetId: string; // component or code block identifier
  message: string;
  createdAt: Date;
}
