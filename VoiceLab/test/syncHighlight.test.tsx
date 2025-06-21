import React from 'react';
import { SyncHighlight } from '../src/syncHighlight';

test('SyncHighlight renders element', () => {
  const transcript = [{ text: 'Hello', start: 0, end: 1 }];
  const element = SyncHighlight({ transcript, currentTime: 0 });
  expect(React.isValidElement(element)).toBe(true);
});
