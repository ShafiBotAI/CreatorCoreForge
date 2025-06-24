export type RenderJob = { id: string; priority: number; task: () => Promise<void> };

export class RenderQueueManager {
  private queue: RenderJob[] = [];

  add(job: RenderJob): void {
    this.queue.push(job);
    this.queue.sort((a, b) => b.priority - a.priority);
  }

  async runNext(): Promise<void> {
    const job = this.queue.shift();
    if (job) await job.task();
  }
}
