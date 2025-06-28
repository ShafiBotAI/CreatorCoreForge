import { ACXExporter } from '../src/acxExporter';

 test('ACXExporter adds header', async () => {
  const exp = new ACXExporter();
  const blob = new Blob(['hello'], { type: 'audio/mp3' });
  const out = await exp.generate(blob);
  const array = await out.arrayBuffer();
  const text = new TextDecoder().decode(array);
  expect(text.startsWith('ACXHDR')).toBe(true);
});
