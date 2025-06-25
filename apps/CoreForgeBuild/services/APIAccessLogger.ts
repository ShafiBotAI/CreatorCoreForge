interface LogEntry {
  userId: string;
  endpoint: string;
  timestamp: Date;
}

export class APIAccessLogger {
  private logs = new Map<string, LogEntry[]>();

  record(projectId: string, userId: string, endpoint: string) {
    const arr = this.logs.get(projectId) || [];
    arr.push({ userId, endpoint, timestamp: new Date() });
    this.logs.set(projectId, arr);
  }

  list(projectId: string, userId?: string): LogEntry[] {
    const arr = this.logs.get(projectId) || [];
    return userId ? arr.filter(l => l.userId === userId) : [...arr];
  }
}
