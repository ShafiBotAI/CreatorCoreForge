import React from 'react';

export interface NowPlayingBadgeProps {
  title: string;
  progress: number;
  isPlaying: boolean;
  onToggle: () => void;
}

export const NowPlayingBadge: React.FC<NowPlayingBadgeProps> = ({
  title,
  progress,
  isPlaying,
  onToggle,
}) => (
  <div className="now-playing-badge" style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
    <span>Now Playing: {title}</span>
    <button onClick={onToggle}>{isPlaying ? 'Pause' : 'Play'}</button>
    <div style={{ flex: 1, height: '4px', background: '#ccc' }}>
      <div
        style={{ width: `${Math.round(progress * 100)}%`, height: '100%', background: '#6a5acd' }}
      />
    </div>
  </div>
);
