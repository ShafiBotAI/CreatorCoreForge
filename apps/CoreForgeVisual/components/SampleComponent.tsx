import React, { useState } from 'react';
import { useStoryboardCache } from '../hooks/useStoryboardCache';

export interface SampleComponentProps {
  title: string;
  cacheKey?: string;
  onSave?: (frames: number) => void;
}

export default function SampleComponent({ title, cacheKey = 'sample-board', onSave }: SampleComponentProps) {
  const { board, save } = useStoryboardCache(cacheKey);
  const [script, setScript] = useState<string>(board?.frames.join('\n') || '');
  const [frameCount, setFrameCount] = useState<number>(board?.frames.length || 0);

  const handleSave = () => {
    const frames = script.split('\n').filter(line => line.trim() !== '');
    save({ id: cacheKey, frames });
    setFrameCount(frames.length);
    onSave?.(frames.length);
  };

  return (
    <div className="sample-component">
      <h2>{title}</h2>
      <textarea
        value={script}
        onChange={e => setScript(e.target.value)}
        rows={4}
        style={{ width: '100%' }}
      />
      <button onClick={handleSave}>Save Storyboard</button>
      <p data-testid="export-count">Frames: {frameCount}</p>
    </div>
  );
}
