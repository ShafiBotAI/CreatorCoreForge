const express = require('express');
const fs = require('fs');
const path = require('path');

const app = express();
const PORT = process.env.METRICS_PORT || 4000;
const METRICS_FILE = path.join(__dirname, '..', 'generated', 'metrics.json');

app.use(express.json());

function loadMetrics() {
  if (fs.existsSync(METRICS_FILE)) {
    return JSON.parse(fs.readFileSync(METRICS_FILE, 'utf8'));
  }
  return { crashes: [], performance: [] };
}

function saveMetrics(data) {
  fs.mkdirSync(path.dirname(METRICS_FILE), { recursive: true });
  fs.writeFileSync(METRICS_FILE, JSON.stringify(data, null, 2));
}

app.post('/crash', (req, res) => {
  const data = loadMetrics();
  data.crashes.push({ time: Date.now(), info: req.body });
  saveMetrics(data);
  res.json({ status: 'recorded' });
});

app.post('/perf', (req, res) => {
  const data = loadMetrics();
  data.performance.push({ time: Date.now(), metrics: req.body });
  saveMetrics(data);
  res.json({ status: 'recorded' });
});

app.get('/dashboard', (req, res) => {
  res.json(loadMetrics());
});

app.listen(PORT, () => {
  console.log(`Metrics dashboard running on port ${PORT}`);
});
