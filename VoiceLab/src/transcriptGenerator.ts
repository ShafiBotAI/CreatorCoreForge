export interface TranscriptGeneratorOptions {
  apiKey?: string;
  model?: string;
  language?: string;
}

export class TranscriptGenerator {
  private apiKey: string;
  private model: string;
  private language?: string;

  constructor(options: TranscriptGeneratorOptions = {}) {
    this.apiKey = options.apiKey || process.env.OPENAI_API_KEY || '';
    this.model = options.model || 'whisper-1';
    this.language = options.language;
  }

  async generateTranscript(audio: Blob | File): Promise<string> {
    if (!this.apiKey) {
      throw new Error('OpenAI API key missing');
    }
    const form = new FormData();
    form.append('file', audio);
    form.append('model', this.model);
    if (this.language) form.append('language', this.language);

    const response = await fetch('https://api.openai.com/v1/audio/transcriptions', {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${this.apiKey}`
      },
      body: form
    });

    if (!response.ok) {
      const txt = await response.text();
      throw new Error(`Transcription failed: ${response.status} ${txt}`);
    }

    const data = await response.json();
    return data.text as string;
  }
}
