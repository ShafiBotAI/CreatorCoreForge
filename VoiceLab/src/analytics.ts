export function trackEvent(name: string, props: Record<string, unknown> = {}) {
  const fb = (globalThis as { firebase?: { analytics?: () => { logEvent: (n: string, p: Record<string, unknown>) => void } } }).firebase;
  if (fb?.analytics) {
    fb.analytics().logEvent(name, props);
  }
  console.log('track', name, props);
}
