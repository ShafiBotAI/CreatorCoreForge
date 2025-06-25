export class AutoUpdaterService {
  constructor(private updateUrl: string = 'https://example.com/latest.json') {}

  async checkForUpdate(currentVersion: string): Promise<string | null> {
    const res = await fetch(this.updateUrl);
    const json = await res.json().catch(() => null);
    const latest = json?.version as string | undefined;
    if (!latest) return null;
    return this.compare(latest, currentVersion) > 0 ? latest : null;
  }

  private compare(a: string, b: string): number {
    const pa = a.split('.').map(n => parseInt(n));
    const pb = b.split('.').map(n => parseInt(n));
    const len = Math.max(pa.length, pb.length);
    for (let i = 0; i < len; i++) {
      const va = pa[i] || 0;
      const vb = pb[i] || 0;
      if (va > vb) return 1;
      if (va < vb) return -1;
    }
    return 0;
  }
}
