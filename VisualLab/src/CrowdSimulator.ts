export interface CrowdMember { id: number; }

export class CrowdSimulator {
  simulate(count: number): CrowdMember[] {
    return Array.from({ length: count }, (_, i) => ({ id: i }));
  }
}
