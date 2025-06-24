import * as Sentry from '@sentry/node';

/** Simple performance monitor that logs metrics to Sentry */
export class PerformanceMonitor {
  constructor(dsn?: string) {
    if (dsn) {
      Sentry.init({ dsn });
    }
  }

  /**
   * Record a performance metric and send to Sentry.
   * @param metric name of metric
   * @param value numeric value
   */
  record(metric: string, value: number): void {
    Sentry.captureMessage(`metric:${metric} value:${value}`, {
      level: 'info',
    });
  }
}
