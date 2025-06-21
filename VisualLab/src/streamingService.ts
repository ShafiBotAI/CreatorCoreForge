import { Readable } from 'stream';
import { streamingOptimizer } from './streamingOptimizer.ts';

export class VideoStreamingService {
  private projects: Record<string, Buffer[]> = {};
  private bitrate: number;

  constructor(bitrate = 800_000) {
    this.bitrate = bitrate; // bytes per second
  }

  registerProject(id: string, chunks: Buffer[]): void {
    this.projects[id] = chunks;
  }

  async stream(projectId: string): Promise<Readable> {
    const chunks = this.projects[projectId];
    if (!chunks) throw new Error('project not found');

    const optimized = streamingOptimizer(chunks, this.bitrate);
    const stream = new Readable({ read() {} });
    let i = 0;

    const pushNext = () => {
      if (i >= optimized.length) {
        stream.push(null);
        return;
      }
      const chunk = optimized[i++];
      stream.push(chunk);
      const delay = Math.max(Math.ceil((chunk.length / this.bitrate) * 1000), 10);
      setTimeout(pushNext, delay);
    };

    pushNext();
    return stream;
  }
}
