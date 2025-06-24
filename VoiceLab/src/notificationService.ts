export async function sendNotification(token: string, title: string, body: string) {
  const fcm = (globalThis as { firebase?: { messaging?: () => { send: (msg: unknown) => Promise<void> } } }).firebase?.messaging?.();
  if (fcm) {
    await fcm.send({ token, notification: { title, body } });
  }
}
