import assert from 'node:assert';
import { FormExportService } from '../services/FormExportService';
import { Field } from '../components/FormBuilderEngine';

const fields: Field[] = [
  { name: 'email', label: 'Email', type: 'email', required: true },
  { name: 'age', label: 'Age', type: 'number' }
];

const svc = new FormExportService();
const json = svc.toJSONSchema(fields);
assert.ok(json.includes('email'));
assert.ok(json.includes('required'));

const react = svc.toReactComponent(fields);
assert.ok(react.includes('input'));

const vue = svc.toVueComponent(fields);
assert.ok(vue.includes('<template>'));
console.log('FormExportService tests passed');
