import http from 'node:http';
import assert from 'node:assert';
import { AutoUpdaterService } from '../services/AutoUpdaterService';

const server = http.createServer((_, res) => {
  res.writeHead(200, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify({ version: '2.0' }));
});

server.listen(0, async () => {
  const { port } = server.address() as any;
  const svc = new AutoUpdaterService(`http://localhost:${port}`);
  const latest = await svc.checkForUpdate('1.0');
  assert.strictEqual(latest, '2.0');
  server.close(() => console.log('AutoUpdaterService tests passed'));
});
