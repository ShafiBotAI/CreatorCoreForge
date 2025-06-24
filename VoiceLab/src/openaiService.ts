export interface CompletionOptions {
  prompt: string;
  model?: string;
  apiKey?: string;
}

export async function complete(options: CompletionOptions): Promise<string> {
  const apiKey = options.apiKey || process.env.OPENAI_API_KEY || '';
  if (!apiKey) {
    throw new Error('OpenAI API key missing');
  }
  const model = options.model || 'gpt-4o';
  const response = await fetch('https://api.openai.com/v1/chat/completions', {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${apiKey}`,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      model,
      messages: [{ role: 'user', content: options.prompt }]
    })
  });
  if (!response.ok) {
    const txt = await response.text();
    throw new Error(`Completion failed: ${response.status} ${txt}`);
  }
  const data = await response.json();
  return data.choices[0].message.content as string;
}
