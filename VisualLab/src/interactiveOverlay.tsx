import React from 'react';

export type Hotspot = { x: number; y: number; onClick: () => void };

export const InteractiveOverlay: React.FC<React.PropsWithChildren<{ hotspots: Hotspot[] }>> = ({ hotspots, children }) => (
  <div style={{ position: 'relative' }}>
    {children}
    {hotspots.map((hs, i) => (
      <div
        key={i}
        onClick={hs.onClick}
        style={{ position: 'absolute', left: hs.x, top: hs.y, width: 20, height: 20, cursor: 'pointer' }}
      />
    ))}
  </div>
);
