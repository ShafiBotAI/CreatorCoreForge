export function logRenderTime(label: string, ms: number) {
  console.log(`render:${label}:${ms}`);
  const sentry = (globalThis as { Sentry?: { captureMessage: (msg: string) => void } }).Sentry;
  sentry?.captureMessage(`render ${label} ${ms}`);
}
