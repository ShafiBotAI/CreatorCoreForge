export type PerfMetrics = { cpu: number; memory: number };

export class PerformanceProfiler {
  private startCpu = process.cpuUsage();
  private startMem = process.memoryUsage().rss;

  end(): PerfMetrics {
    const cpu = process.cpuUsage(this.startCpu);
    const mem = process.memoryUsage().rss - this.startMem;
    return { cpu: cpu.user + cpu.system, memory: mem };
  }
}
