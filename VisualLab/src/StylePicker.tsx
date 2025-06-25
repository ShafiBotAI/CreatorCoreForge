import React from 'react';

export type StyleOption = 'anime' | 'noir' | 'fantasy' | 'default';

export const StylePicker: React.FC<{ value: StyleOption; onChange: (v: StyleOption) => void }> = ({ value, onChange }) => (
  <select value={value} onChange={e => onChange(e.target.value as StyleOption)}>
    <option value="anime">Anime</option>
    <option value="noir">Noir</option>
    <option value="fantasy">Fantasy</option>
    <option value="default">Default</option>
  </select>
);
