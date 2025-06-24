import { PromptParser, ParseResult } from './PromptParser';

/**
 * VoicePromptParser converts an audio buffer into text using a
 * placeholder implementation and then delegates to PromptParser.
 */
export class VoicePromptParser {
  constructor(private parser = new PromptParser()) {}

  parseVoice(data: Buffer): ParseResult {
    const text = data.toString('utf8');
    return this.parser.parse(text);
  }
}
