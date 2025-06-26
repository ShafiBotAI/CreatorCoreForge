import assert from 'node:assert';
import { LocalizationService } from '../services/LocalizationService';

const svc = new LocalizationService('es');
assert.strictEqual(svc.t('addField'), 'Agregar campo');
assert.strictEqual(svc.t('required'), 'Requerido');
console.log('LocalizationService tests passed');
