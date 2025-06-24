export interface TTSSegment {
  id: string;
  text: string;
}

export interface TTSOptions {
  voice?: string;
  rate?: number;
  pitch?: number;
}

export class TTSRenderer {
  private queue: TTSSegment[] = [];
  private processing = false;

  enqueue(segment: TTSSegment, options?: TTSOptions): void {
    this.queue.push(segment);
    if (!this.processing) {
      this.processNext(options);
    }
  }

  isIdle(): boolean {
    return !this.processing && this.queue.length === 0;
  }

  private async processNext(options?: TTSOptions): Promise<void> {
    const seg = this.queue.shift();
    if (!seg) {
      this.processing = false;
      return;
    }
    this.processing = true;
    await this.renderSegment(seg);
    this.processing = false;
    this.processNext(options);
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
