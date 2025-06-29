import { debounce } from '../src/utils/debounce';
import fc from 'fast-check';
import { jest } from '@jest/globals';

test('debounce eventually calls underlying function', async () => {
  await fc.assert(
    fc.asyncProperty(fc.array(fc.integer(), { minLength: 1, maxLength: 5 }), async nums => {
      const fn = jest.fn();
      const debounced = debounce(fn, 10);
      nums.forEach(n => debounced(n));
      await new Promise(r => setTimeout(r, 20));
      expect(fn).toHaveBeenCalledTimes(1);
    })
  );
});
