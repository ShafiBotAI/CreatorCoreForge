const https = require('https');

function requestJSON(options, data) {
  return new Promise((resolve, reject) => {
    const req = https.request(options, res => {
      let body = '';
      res.on('data', chunk => body += chunk);
      res.on('end', () => {
        if (res.statusCode && res.statusCode >= 200 && res.statusCode < 300) {
          try {
            resolve(JSON.parse(body));
          } catch (err) {
            reject(err);
          }
        } else {
          reject(new Error(`Request failed ${res.statusCode} ${body}`));
        }
      });
    });
    req.on('error', reject);
    if (data) req.write(JSON.stringify(data));
    req.end();
  });
}

async function generateText(prompt, apiKey = process.env.OPENAI_API_KEY) {
  if (!apiKey) throw new Error('OPENAI_API_KEY missing');
  const options = {
    hostname: 'api.openai.com',
    path: '/v1/chat/completions',
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${apiKey}`
    }
  };
  const data = {
    model: 'gpt-4o',
    messages: [{ role: 'user', content: prompt }]
  };
  const res = await requestJSON(options, data);
  return res.choices && res.choices[0].message.content;
}

async function synthesizeSpeech(text, voiceID, apiKey = process.env.ELEVEN_API_KEY) {
  if (!apiKey) throw new Error('ELEVEN_API_KEY missing');
  return new Promise((resolve, reject) => {
    const options = {
      hostname: 'api.elevenlabs.io',
      path: `/v1/text-to-speech/${voiceID}`,
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${apiKey}`
      }
    };
    const req = https.request(options, res => {
      const chunks = [];
      res.on('data', c => chunks.push(c));
      res.on('end', () => {
        if (res.statusCode && res.statusCode >= 200 && res.statusCode < 300) {
          resolve(Buffer.concat(chunks));
        } else {
          reject(new Error(`Request failed ${res.statusCode}`));
        }
      });
    });
    req.on('error', reject);
    req.write(JSON.stringify({ text }));
    req.end();
  });
}

module.exports = { generateText, synthesizeSpeech };
