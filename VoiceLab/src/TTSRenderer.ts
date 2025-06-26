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
  /** Callback triggered when a render exceeds the latency threshold */
  onLatencySpike?: (latency: number, segment: TTSSegment) => void;
  /** Threshold in ms for latency spike monitoring */
  latencyThreshold?: number;
  /** Base delay for retry logic */
  baseRetryDelay?: number;
  /** Maximum backoff delay */
  maxRetryDelay?: number;
}

export class TTSRenderer {
  private queue: { seg: TTSSegment; opt?: TTSOptions }[] = [];
  private active = 0;
  private readonly concurrency: number;
  private readonly config: {
    onLatencySpike?: (latency: number, segment: TTSSegment) => void;
    latencyThreshold: number;
    baseRetryDelay: number;
    maxRetryDelay: number;
  };
  private scheduled = false;

  constructor(config: TTSRendererConfig = {}) {
    this.concurrency = config.concurrency ?? 1;
    this.config = {
      onLatencySpike: config.onLatencySpike,
      latencyThreshold: config.latencyThreshold ?? 50,
      baseRetryDelay: config.baseRetryDelay ?? 50,
      maxRetryDelay: config.maxRetryDelay ?? 1000,
    };
  }

  enqueue(segment: TTSSegment, options?: TTSOptions): void {
    this.queue.push({ seg: segment, opt: options });
    this.schedule();
  }

  isIdle(): boolean {
    return this.queue.length === 0 && this.active === 0;
  }

  private schedule(): void {
    if (!this.scheduled) {
      this.scheduled = true;
      setImmediate(() => {
        this.scheduled = false;
        this.process();
      });
    }
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
      if (
        latency > this.config.latencyThreshold &&
        this.config.onLatencySpike
      ) {
        this.config.onLatencySpike(latency, segment);
      }
    } catch {
      const jitter = Math.random() * this.config.baseRetryDelay;
      const delay = Math.min(
        this.config.maxRetryDelay,
        this.config.baseRetryDelay * Math.pow(2, attempt)
      );
      await new Promise((r) => setTimeout(r, delay + jitter));
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
