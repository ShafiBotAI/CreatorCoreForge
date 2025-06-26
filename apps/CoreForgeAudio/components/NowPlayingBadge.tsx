import React from 'react';

export interface NowPlayingBadgeProps {
  title: string;
}

export const NowPlayingBadge: React.FC<NowPlayingBadgeProps> = ({ title }) => (
  <div className="now-playing-badge">Now Playing: {title}</div>
);
