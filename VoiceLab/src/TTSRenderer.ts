export interface TTSSegment {
  id: string;
  text: string;
}

export interface TTSOptions {
  voice?: string;
  rate?: number;
  pitch?: number;
}

export interface TTSRendererConfig {
  /** Number of segments processed concurrently */
  concurrency?: number;
  /** Callback triggered when a render exceeds 50ms */
  onLatencySpike?: (latency: number, segment: TTSSegment) => void;
}

export class TTSRenderer {
  private queue: { seg: TTSSegment; opt?: TTSOptions }[] = [];
  private active = 0;
  private readonly concurrency: number;
  private readonly config: TTSRendererConfig;

  constructor(config: TTSRendererConfig = {}) {
    this.concurrency = config.concurrency ?? 1;
    this.config = config;
  }

  enqueue(segment: TTSSegment, options?: TTSOptions): void {
    this.queue.push({ seg: segment, opt: options });
    this.process();
  }

  isIdle(): boolean {
    return this.queue.length === 0 && this.active === 0;
  }

  private process(): void {
    while (this.active < this.concurrency && this.queue.length > 0) {
      const { seg, opt } = this.queue.shift()!;
      this.active++;
      this.renderWithRetry(seg, opt).finally(() => {
        this.active--;
        this.process();
      });
    }
  }

  private async renderWithRetry(
    segment: TTSSegment,
    options?: TTSOptions,
    attempt = 0
  ): Promise<void> {
    const start = Date.now();
    try {
      await this.renderSegment(segment, options);
      const latency = Date.now() - start;
      if (latency > 50 && this.config.onLatencySpike) {
        this.config.onLatencySpike(latency, segment);
      }
    } catch {
      const delay = Math.min(1000, Math.pow(2, attempt) * 50);
      await new Promise((r) => setTimeout(r, delay));
      return this.renderWithRetry(segment, options, attempt + 1);
    }
  }

  async renderSegment(segment: TTSSegment, options?: TTSOptions): Promise<void> {
    const { renderSegment } = await import('./ttsService');
    const voice = options?.voice ?? 'default';
    const blob = await renderSegment(
      { id: segment.id, text: segment.text, chapter: 0 },
      voice
    );
    console.log(
      `Rendered segment ${segment.id} (${blob.size} bytes) with voice ${voice}`
    );
  }
}
