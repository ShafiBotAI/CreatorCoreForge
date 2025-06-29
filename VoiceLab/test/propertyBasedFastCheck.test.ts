import fc from 'fast-check';

function reverseTwice(s: string): string {
  return s.split('').reverse().join('').split('').reverse().join('');
}

describe('reverseTwice', () => {
  it('should return the original string', () => {
    fc.assert(fc.property(fc.string(), (s) => reverseTwice(s) === s));
  });
});
