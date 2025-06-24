export function modulateCadence(samples: number[], factor = 0.5): number[] {
  return samples.map((s, i) => s * (1 + factor * (i % 2 === 0 ? 1 : -1)));
}

export function simulateInterrupt(samples: number[], points: number[]): number[] {
  const output = [...samples];
  points.forEach((p) => {
    if (p >= 0 && p < output.length) output[p] = 0;
  });
  return output;
}

export function generateStutterLaugh(base: number[], repeats = 3): number[] {
  const out: number[] = [];
  for (let i = 0; i < repeats; i++) {
    out.push(...base, 0);
  }
  return out;
}

export function applyWhisper(samples: number[], start: number, end: number): number[] {
  return samples.map((s, i) => (i >= start && i <= end ? s * 0.5 : s));
}

export function switchToneMidSentence(samples: number[], index: number, scale = 1): number[] {
  return samples.map((s, i) => (i >= index ? s * scale : s));
}
