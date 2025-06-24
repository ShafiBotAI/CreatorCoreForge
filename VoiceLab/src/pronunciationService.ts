export type Phoneme = string;

export class PronunciationService {
  async suggestCorrections(text: string): Promise<Phoneme[]> {
    return text.split(' ').map(w => w.toLowerCase());
  }
}
