import React from 'react';

export interface TranscriptSegment {
  text: string;
  start: number; // seconds
  end: number; // seconds
}

export interface SyncHighlightProps {
  transcript: TranscriptSegment[];
  currentTime: number;
}

export const SyncHighlight: React.FC<SyncHighlightProps> = ({ transcript, currentTime }) => {
  return (
    <p>
      {transcript.map((seg, i) => {
        const active = currentTime >= seg.start && currentTime <= seg.end;
        const style = active ? { backgroundColor: 'yellow' } : undefined;
        return (
          <span key={i} style={style}>
            {seg.text + ' '}
          </span>
        );
      })}
    </p>
  );
};
