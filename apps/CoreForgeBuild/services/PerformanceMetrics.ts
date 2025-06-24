export interface Metrics {
  loadTime: number;
  memory?: number;
  fps?: number;
}

export class PerformanceMetrics {
  static measureLoad(start: number): Metrics {
    const loadTime = performance.now() - start;
    return { loadTime };
  }
}
