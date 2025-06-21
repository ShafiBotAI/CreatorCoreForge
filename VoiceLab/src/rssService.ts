export interface Episode {
  title: string;
  audioUrl: string;
  description?: string;
}

export class RSSService {
  generateFeed(episodes: Episode[]): string {
    const items = episodes.map(e => `<item><title>${e.title}</title><enclosure url="${e.audioUrl}" /></item>`).join('');
    return `<rss><channel>${items}</channel></rss>`;
  }
}
