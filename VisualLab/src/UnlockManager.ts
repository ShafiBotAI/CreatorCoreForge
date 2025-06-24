export interface UnlockOptions {
  autoUpload?: boolean;
  nsfw?: boolean;
  creatorTab?: boolean;
}

export class UnlockManager {
  private unlocks = new Map<string, UnlockOptions>();

  applyCode(user: string, code: string): void {
    if (code === 'CREATOR') {
      this.enable(user, { creatorTab: true });
    }
  }

  enable(user: string, opts: UnlockOptions): void {
    const existing = this.unlocks.get(user) || {};
    this.unlocks.set(user, { ...existing, ...opts });
  }

  isEnabled(user: string, key: keyof UnlockOptions): boolean {
    return !!(this.unlocks.get(user) || {})[key];
  }
}
