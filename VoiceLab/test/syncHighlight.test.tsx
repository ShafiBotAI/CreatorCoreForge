import assert from 'node:assert';
import React from 'react';
import { SyncHighlight } from '../src/syncHighlight.tsx';

const transcript = [{ text: 'Hello', start: 0, end: 1 }];
const element = SyncHighlight({ transcript, currentTime: 0 });
assert.ok(React.isValidElement(element));
console.log('SyncHighlight test passed');
