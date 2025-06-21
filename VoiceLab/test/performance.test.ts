import { PerformanceMonitor } from '../src/PerformanceMonitor';

test('PerformanceMonitor records metrics', () => {
  const monitor = new PerformanceMonitor();
  expect(() => monitor.record('testMetric', 123)).not.toThrow();
});
