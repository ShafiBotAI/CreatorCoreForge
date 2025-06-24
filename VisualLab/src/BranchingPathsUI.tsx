import React from 'react';

export interface BranchOption {
  id: string;
  onSelect: () => void;
}

export const BranchingPathsUI: React.FC<{ options: BranchOption[] }> = ({ options }) => (
  <div>
    {options.map(opt => (
      <button key={opt.id} onClick={opt.onSelect}>{opt.id}</button>
    ))}
  </div>
);
