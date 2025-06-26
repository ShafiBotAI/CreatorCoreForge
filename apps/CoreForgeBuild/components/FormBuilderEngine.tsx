import React, { useEffect, useState } from 'react';
import { parseClipboard } from '../services/ClipboardFormParser';
import { formBlueprintLibrary } from '../services/FormBlueprintLibrary';
import { analyticsService } from '../services/AnalyticsService';
import { LocalizationService, Locale } from '../services/LocalizationService';

export interface Field {
  name: string;
  label: string;
  type: 'text' | 'number' | 'email';
  required?: boolean;
}

export interface FormBuilderEngineProps {
  onChange?: (fields: Field[]) => void;
  /** unique id to persist session state */
  formId?: string;
  /** locale for built-in labels */
  locale?: Locale;
}

export const FormBuilderEngine: React.FC<FormBuilderEngineProps> = ({ onChange, formId = 'default', locale = 'en' }) => {
  const sessionKey = `form_${formId}_fields`;
  const [fields, setFields] = useState<Field[]>([]);
  const loc = new LocalizationService(locale);

  // restore from session
  useEffect(() => {
    const saved = sessionStorage.getItem(sessionKey);
    if (saved) {
      setFields(JSON.parse(saved));
    }
  }, [sessionKey]);

  // persist to session
  useEffect(() => {
    sessionStorage.setItem(sessionKey, JSON.stringify(fields));
  }, [fields, sessionKey]);
  const addField = () => {
    const newField: Field = { name: `field${fields.length + 1}`, label: 'Label', type: 'text' };
    const next = [...fields, newField];
    setFields(next);
    onChange?.(next);
    analyticsService.recordFieldAdd();
  };

  const pasteFromClipboard = async () => {
    try {
      const text = await navigator.clipboard.readText();
      const parsed = parseClipboard(text);
      if (parsed.length > 0) {
        if (window.confirm('Replace current form with clipboard fields?')) {
          setFields(parsed);
          onChange?.(parsed);
        }
      }
    } catch {
      /* clipboard not available */
    }
  };

  const saveBlueprint = () => {
    if (window.confirm('Save form blueprint?')) {
      formBlueprintLibrary.save({ id: formId, fields });
      analyticsService.recordSubmit(true);
      alert('Saved!');
    }
  };
  const updateField = (index: number, key: keyof Field, value: string | boolean) => {
    const next = fields.map((f, i) => (i === index ? { ...f, [key]: value } : f));
    setFields(next);
    onChange?.(next);
  };

  const submit = () => {
    const valid = fields.every(f => f.label);
    analyticsService.recordSubmit(valid);
    if (valid) {
      alert('Form saved');
    } else {
      alert(loc.t('errorCompleteLabels'));
    }
  };
  return (
    <div onPaste={(e) => { e.preventDefault(); pasteFromClipboard(); }}>
      <button onClick={addField}>{loc.t('addField')}</button>
      <button onClick={pasteFromClipboard}>{loc.t('pasteFields')}</button>
      <button onClick={saveBlueprint}>{loc.t('saveBlueprint')}</button>
      <button onClick={submit}>{loc.t('submit')}</button>
      {fields.map((f, i) => (
        <div key={i}>
          <input
            value={f.label}
            onChange={e => updateField(i, 'label', e.target.value)}
          />
          <select value={f.type} onChange={e => updateField(i, 'type', e.target.value as Field['type'])}>
            <option value="text">Text</option>
            <option value="number">Number</option>
            <option value="email">Email</option>
          </select>
          <label>
            {loc.t('required')}
            <input
              type="checkbox"
              checked={f.required}
              onChange={e => updateField(i, 'required', e.target.checked)}
            />
          </label>
        </div>
      ))}
    </div>
  );
};
