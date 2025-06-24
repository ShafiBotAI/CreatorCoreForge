export interface Version<T = unknown> {
  id: string;
  userId: string;
  createdAt: Date;
  message: string;
  snapshot: T;
  diff?: string;
}
