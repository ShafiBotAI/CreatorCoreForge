export function streamingOptimizer(chunks: Buffer[], bitrate: number): Buffer[] {
  const optimized: Buffer[] = [];
  const target = Math.max(bitrate / 8, 1);
  let current = Buffer.alloc(0);

  for (const chunk of chunks) {
    if (current.length + chunk.length > target && current.length > 0) {
      optimized.push(current);
      current = Buffer.from(chunk);
    } else {
      current = Buffer.concat([current, chunk]);
    }
  }

  if (current.length > 0) optimized.push(current);
  return optimized;
}
