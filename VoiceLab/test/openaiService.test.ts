import { complete } from '../src/openaiService';

const originalFetch = global.fetch;

beforeEach(() => {
  global.fetch = jest.fn().mockResolvedValue({
    ok: true,
    json: async () => ({ choices: [{ message: { content: 'done' } }] })
  }) as any;
});

afterEach(() => {
  global.fetch = originalFetch;
});

test('complete uses fetch with api key', async () => {
  process.env.OPENAI_API_KEY = 'test';
  const text = await complete({ prompt: 'hi' });
  expect(text).toBe('done');
});

test('missing api key throws', async () => {
  delete process.env.OPENAI_API_KEY;
  await expect(complete({ prompt: 'hi' })).rejects.toThrow('OpenAI API key missing');
});
