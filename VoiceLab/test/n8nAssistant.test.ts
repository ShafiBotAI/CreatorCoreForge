import { runN8nAssistant } from '../src/n8nAssistant';
import * as openai from '../src/openaiService';

jest.mock('../src/openaiService');

const mockedComplete = openai.complete as jest.Mock;

beforeEach(() => {
  mockedComplete.mockResolvedValue('assistant');
});

afterEach(() => {
  mockedComplete.mockReset();
});

test('runN8nAssistant forwards instructions and text', async () => {
  const result = await runN8nAssistant('hello', { instructions: 'Act helpful', model: 'gpt-x' });
  expect(result).toBe('assistant');
  expect(mockedComplete).toHaveBeenCalledWith({ prompt: 'Act helpful\nhello', model: 'gpt-x' });
});

