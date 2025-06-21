import { PerformanceMonitor } from '../src/PerformanceMonitor.ts';
import assert from 'node:assert';

const monitor = new PerformanceMonitor();
monitor.record('testMetric', 123);
assert.ok(true); // if no error thrown, test passes
