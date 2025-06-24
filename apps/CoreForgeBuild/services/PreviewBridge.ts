import { EventBus } from './EventBus';
import { ParseResult } from './PromptParser';
import { CodeGenService } from './CodeGenService';

/**
 * PreviewBridge connects PromptParser output to code generation events.
 * When a `parsed` event is emitted on the EventBus, this bridge generates
 * preview code and emits a `generated` event so UI panels can display it.
 */
export class PreviewBridge {
  private latestCode = '';

  constructor(
    private bus: EventBus,
    private codegen: CodeGenService = new CodeGenService()
  ) {
    this.bus.on('parsed', (result: ParseResult) => {
      this.latestCode = this.codegen.generate(result.layout, 'react');
      this.bus.emitGenerated('react', this.latestCode);
    });
  }

  /** Latest generated preview code. */
  getCode() {
    return this.latestCode;
  }
}
