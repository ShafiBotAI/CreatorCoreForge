export class TimelineEditor<T = any> {
  private clips: T[] = [];

  addClip(clip: T): void {
    this.clips.push(clip);
  }

  getTimeline(): T[] {
    return this.clips;
  }
}
