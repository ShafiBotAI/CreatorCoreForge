import React, { useState } from 'react';

export interface Field {
  name: string;
  label: string;
  type: 'text' | 'number' | 'email';
  required?: boolean;
}

export interface FormBuilderEngineProps {
  onChange?: (fields: Field[]) => void;
}

export const FormBuilderEngine: React.FC<FormBuilderEngineProps> = ({ onChange }) => {
  const [fields, setFields] = useState<Field[]>([]);
  const addField = () => {
    const newField: Field = { name: `field${fields.length + 1}`, label: 'Label', type: 'text' };
    const next = [...fields, newField];
    setFields(next);
    onChange?.(next);
  };
  const updateField = (index: number, key: keyof Field, value: string | boolean) => {
    const next = fields.map((f, i) => (i === index ? { ...f, [key]: value } : f));
    setFields(next);
    onChange?.(next);
  };
  return (
    <div>
      <button onClick={addField}>Add Field</button>
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
            Required
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
