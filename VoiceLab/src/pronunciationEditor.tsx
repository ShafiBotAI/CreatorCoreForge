import React, { useState } from 'react';

export function PronunciationEditor() {
  const [word, setWord] = useState('');
  const [phoneme, setPhoneme] = useState('');
  return (
    <div>
      <input value={word} onChange={e => setWord(e.target.value)} placeholder="word" />
      <input value={phoneme} onChange={e => setPhoneme(e.target.value)} placeholder="phoneme" />
      <button onClick={() => alert(`${word}:${phoneme}`)}>Add</button>
    </div>
  );
}
