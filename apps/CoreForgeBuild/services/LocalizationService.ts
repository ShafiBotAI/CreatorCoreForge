export type Locale = 'en' | 'es';

interface Dictionary {
  [key: string]: string;
}

const dictionaries: Record<Locale, Dictionary> = {
  en: {
    addField: 'Add Field',
    pasteFields: 'Paste Fields',
    saveBlueprint: 'Save Blueprint',
    submit: 'Submit',
    required: 'Required',
    errorCompleteLabels: 'Please complete all labels'
  },
  es: {
    addField: 'Agregar campo',
    pasteFields: 'Pegar campos',
    saveBlueprint: 'Guardar plantilla',
    submit: 'Enviar',
    required: 'Requerido',
    errorCompleteLabels: 'Por favor completa todas las etiquetas'
  }
};

export class LocalizationService {
  constructor(private locale: Locale = 'en') {}
  t(key: string): string {
    return (
      dictionaries[this.locale][key] ||
      dictionaries['en'][key] ||
      key
    );
  }
}
