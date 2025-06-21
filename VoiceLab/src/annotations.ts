export interface Annotation {
  id: string;
  time: number;
  text: string;
}

export class AnnotationService {
  private notes: Annotation[] = [];

  add(time: number, text: string): Annotation {
    const note = { id: Math.random().toString(36).slice(2), time, text };
    this.notes.push(note);
    return note;
  }

  list(): Annotation[] {
    return [...this.notes];
  }

  edit(id: string, text: string) {
    const n = this.notes.find(a => a.id === id);
    if (n) n.text = text;
  }

  delete(id: string) {
    this.notes = this.notes.filter(a => a.id !== id);
  }
}
