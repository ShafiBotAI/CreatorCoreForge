import { BookImporter } from '../src/bookImporter';

test('BookImporter parses metadata and chapters', async () => {
  const text = 'Title: Sample Book\nAuthor: Jane Doe\n\nChapter 1\nHello\n\nChapter 2\nWorld';
  const file = new File([text], 'sample.txt');
  const importer = new BookImporter();
  const book = await importer.import(file);
  expect(book.title).toBe('Sample Book');
  expect(book.author).toBe('Jane Doe');
  expect(book.chapters).toHaveLength(2);
  expect(book.chapters[0].text).toBe('Hello');
});
