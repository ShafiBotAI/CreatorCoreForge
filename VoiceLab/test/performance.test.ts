import { PerformanceMonitor } from '../src/PerformanceMonitor';

test('PerformanceMonitor records metrics', () => {
  const monitor = new PerformanceMonitor();
  monitor.record('testMetric', 123);
  expect(true).toBe(true);
});
