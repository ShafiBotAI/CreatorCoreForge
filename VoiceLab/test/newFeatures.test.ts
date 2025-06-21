import { GroupListenService, PronunciationService } from '../src';

test('GroupListenService can create room', async () => {
  const svc = new GroupListenService();
  const room = await svc.createRoom('book1');
  expect(room.bookId).toBe('book1');
});

test('PronunciationService suggests phonemes', async () => {
  const svc = new PronunciationService();
  const result = await svc.suggestCorrections('Hello World');
  expect(result).toEqual(['hello', 'world']);
});
