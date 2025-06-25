export type UserTier = 'Pro' | 'Creator';

export class CreditEngine {
  private usage = new Map<string, number>();
  private credits = new Map<string, number>();

  canConvert(user: string, tier: UserTier): boolean {
    const limit = tier === 'Pro' ? 1 : 3;
    const used = this.usage.get(user) || 0;
    if (used < limit) return true;
    return (this.credits.get(user) || 0) > 0;
  }

  recordConversion(user: string, tier: UserTier): void {
    const used = this.usage.get(user) || 0;
    this.usage.set(user, used + 1);
    if (used >= (tier === 'Pro' ? 1 : 3)) {
      this.credits.set(user, (this.credits.get(user) || 0) - 1);
    }
  }

  buyCredit(user: string, count = 1): void {
    this.credits.set(user, (this.credits.get(user) || 0) + count);
  }
}
