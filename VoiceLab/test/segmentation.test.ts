import { autoSegment } from '../src/segmentation';

const chapters = [{ title: 'c1', text: 'A\n\nB' }];

test('autoSegment splits paragraphs', async () => {
  const segs = await autoSegment(chapters);
  expect(segs).toHaveLength(2);
});
