export class TextOverlayService {
  apply(frame: string, text: string): string {
    return `${frame}-text(${text})`;
  }
}
