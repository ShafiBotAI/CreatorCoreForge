export interface Template {
  id: string;
  name: string;
}

/** Simple in-memory template service */
export class TemplateService {
  private templates: Template[] = [
    { id: 'blank', name: 'Blank Project' },
    { id: 'todo', name: 'Todo App' },
    { id: 'onboarding', name: 'Onboarding Flow Example' }
  ];

  list(): Template[] {
    return [...this.templates];
  }
}
