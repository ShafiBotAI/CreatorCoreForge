import { importBook } from '../src/importer';

describe('importBook', () => {
  it('splits txt by paragraphs', async () => {
    const file = new File(['A\n\nB'], 'test.txt');
    const chapters = await importBook(file);
    expect(chapters).toHaveLength(2);
    expect(chapters[0].text).toBe('A');
  });
});
