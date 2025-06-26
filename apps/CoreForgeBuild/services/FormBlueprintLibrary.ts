import { ClipboardField } from './ClipboardFormParser';

export interface FormBlueprint {
  id: string;
  fields: ClipboardField[];
}

/** Simple localStorage backed blueprint library */
class FormBlueprintLibrary {
  private key = 'ccf_form_blueprints';
  private memory: FormBlueprint[] = [];

  private read(): FormBlueprint[] {
    if (typeof localStorage !== 'undefined') {
      const raw = localStorage.getItem(this.key);
      if (raw) return JSON.parse(raw);
    }
    return this.memory;
  }

  private write(list: FormBlueprint[]) {
    if (typeof localStorage !== 'undefined') {
      localStorage.setItem(this.key, JSON.stringify(list));
    } else {
      this.memory = list;
    }
  }

  save(blueprint: FormBlueprint) {
    const list = this.read().filter(b => b.id !== blueprint.id);
    list.push(blueprint);
    this.write(list);
  }

  get(id: string): FormBlueprint | undefined {
    return this.read().find(b => b.id === id);
  }

  list(): FormBlueprint[] {
    return this.read();
  }
}

export const formBlueprintLibrary = new FormBlueprintLibrary();
