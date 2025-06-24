/**
 * Simplified AI assistant inspired by n8n's OpenAiAssistant node.
 * Leverages the existing openaiService to run prompts.
 * This derivative work references n8n code under the Sustainable Use License.
 */
import { complete } from './openaiService';

export interface AssistantOptions {
  /** Optional system instructions prepended to the user text */
  instructions?: string;
  /** Model identifier passed to openaiService */
  model?: string;
  /** Optional name for the assistant */
  name?: string;
}

export async function runN8nAssistant(text: string, options: AssistantOptions = {}): Promise<string> {
  const prompt = options.instructions ? `${options.instructions}\n${text}` : text;
  return complete({ prompt, model: options.model });
}

