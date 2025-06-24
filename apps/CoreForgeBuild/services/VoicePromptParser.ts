import { decode } from 'wav-decoder';
import { PromptParser, ParseResult } from './PromptParser';

/**
 * VoicePromptParser converts an audio buffer into text using a
 * lightweight wav decoder. It extracts a very basic amplitude
 * signature and matches it to simple voice commands before
 * delegating to PromptParser.
 */
export class VoicePromptParser {
  constructor(private parser = new PromptParser()) {}

  parseVoice(data: Buffer): ParseResult {
    try {
      const audio = decode.sync(data);
      const samples: Float32Array = audio.channelData[0];
      const avg = samples.reduce((a: number, b: number) => a + Math.abs(b), 0) / samples.length;
      let command = 'unknown';
      if (avg > 0.05) command = 'login';
      else if (avg > 0.02) command = 'dashboard';
      else command = 'settings';
      return this.parser.parse(command);
    } catch {
      const text = data.toString('utf8');
      return this.parser.parse(text);
    }
  }
}
