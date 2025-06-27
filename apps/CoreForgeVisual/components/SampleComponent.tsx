import React, { useState } from 'react';

export interface SampleComponentProps {
  title: string;
  onExport?: (count: number) => void;
}

export default function SampleComponent({ title, onExport }: SampleComponentProps) {
  const [count, setCount] = useState(0);

  const handleExport = () => {
    const next = count + 1;
    setCount(next);
    onExport?.(next);
  };

  return (
    <div className="sample-component">
      <h2>{title}</h2>
      <button onClick={handleExport}>Export</button>
      <p data-testid="export-count">Exports: {count}</p>
    </div>
  );
}
