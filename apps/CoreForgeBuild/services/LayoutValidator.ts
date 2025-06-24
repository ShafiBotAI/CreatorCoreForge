/**
 * LayoutValidator performs a very small sanity check on
 * HTML strings and attempts to close unbalanced tags.
 */
export class LayoutValidator {
  correct(html: string): string {
    const stack: string[] = [];
    const result: string[] = [];
    const regex = /<\/?([a-zA-Z0-9]+)[^>]*>/g;
    let lastIndex = 0;
    let m: RegExpExecArray | null;
    while ((m = regex.exec(html)) !== null) {
      result.push(html.slice(lastIndex, m.index));
      const tag = m[1];
      const isClose = m[0][1] === '/';
      if (!isClose) {
        stack.push(tag);
        result.push(m[0]);
      } else {
        while (stack.length && stack[stack.length - 1] !== tag) {
          result.push(`</${stack.pop()}>`);
        }
        if (stack.length) {
          stack.pop();
          result.push(m[0]);
        }
      }
      lastIndex = regex.lastIndex;
    }
    result.push(html.slice(lastIndex));
    while (stack.length) {
      result.push(`</${stack.pop()}>`);
    }
    return result.join('');
  }
}
