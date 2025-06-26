import { Field } from '../components/FormBuilderEngine';

export class FormExportService {
  toJSONSchema(fields: Field[]): string {
    const schema: any = {
      type: 'object',
      properties: {},
      required: [] as string[],
    };
    for (const f of fields) {
      (schema.properties as any)[f.name] = { type: f.type };
      if (f.required) schema.required.push(f.name);
    }
    return JSON.stringify(schema, null, 2);
  }

  toReactComponent(fields: Field[], componentName = 'GeneratedForm'): string {
    const inputs = fields
      .map(f => `      <input name=\"${f.name}\" type=\"${f.type}\"${f.required ? ' required' : ''} />`)
      .join('\n');
    return `import React from 'react';

export const ${componentName}: React.FC = () => (
  <form>\n${inputs}\n  </form>
);\n`;
  }

  toVueComponent(fields: Field[], componentName = 'GeneratedForm'): string {
    const inputs = fields
      .map(f => `    <input name=\"${f.name}\" type=\"${f.type}\"${f.required ? ' required' : ''}>`)
      .join('\n');
    return `<template>\n  <form>\n${inputs}\n  </form>\n</template>\n<script>\nexport default {\n  name: '${componentName}'\n};\n</script>\n`;
  }
}
