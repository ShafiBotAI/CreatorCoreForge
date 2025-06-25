import { debounce } from '../src/utils/debounce';

jest.useFakeTimers();

test('debounce delays function execution', () => {
  const fn = jest.fn();
  const debounced = debounce(fn, 100);
  debounced();
  debounced();
  expect(fn).not.toBeCalled();
  jest.runAllTimers();
  expect(fn).toBeCalledTimes(1);
});
