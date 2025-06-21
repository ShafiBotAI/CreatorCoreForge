export class BookmarkService {
  async export(format: 'json' | 'csv'): Promise<Blob> {
    const data = format === 'csv' ? 'page,comment' : JSON.stringify([]);
    return new Blob([data], { type: 'text/plain' });
  }
}
