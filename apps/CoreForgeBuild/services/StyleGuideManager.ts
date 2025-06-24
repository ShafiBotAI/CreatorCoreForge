export type StyleGuide = 'standard' | 'company' | 'minimal';

/** Simple registry of style guide preferences. */
export class StyleGuideManager {
  private current: StyleGuide = 'standard';

  set(guide: StyleGuide) {
    this.current = guide;
  }

  get() {
    return this.current;
  }
}
