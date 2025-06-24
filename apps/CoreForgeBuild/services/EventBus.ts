import { EventEmitter } from 'events';
import { ParseResult } from './PromptParser';

export interface GeneratedEvent {
  target: string;
  code: string;
}

export class EventBus extends EventEmitter {
  emitParsed(result: ParseResult) {
    this.emit('parsed', result);
  }
  emitGenerated(target: string, code: string) {
    const payload: GeneratedEvent = { target, code };
    this.emit('generated', payload);
  }
}
