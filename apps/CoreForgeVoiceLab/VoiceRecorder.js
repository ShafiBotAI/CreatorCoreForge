import fs from 'fs/promises';

/**
 * Record a short voice sample by generating silent PCM data.
 * This avoids hardware dependencies while providing a real file.
 */
export async function recordVoice(samplePath, durationMs = 1000) {
  const bytes = Buffer.alloc(16 * durationMs); // fake 16 kHz mono samples
  await fs.writeFile(samplePath, bytes);
  return samplePath;
}

/**
 * Naively analyze a voice sample by returning its average amplitude.
 */
export async function analyzeVoice(samplePath) {
  const data = await fs.readFile(samplePath);
  let sum = 0;
  for (const byte of data) sum += Math.abs(byte - 128);
  const avg = sum / data.length;
  return { averageAmplitude: avg };
}
