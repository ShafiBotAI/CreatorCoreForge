export class ContentFilter {
  private verifiedUsers = new Set<string>();

  verify(user: string): void {
    this.verifiedUsers.add(user);
  }

  canPreview(user: string): boolean {
    return this.verifiedUsers.has(user);
  }
}
