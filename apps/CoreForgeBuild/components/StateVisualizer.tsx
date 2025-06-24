import React from 'react';

export const StateVisualizer: React.FC<{ state: unknown }> = ({ state }) => (
  <pre style={{ maxHeight: 200, overflow: 'auto', background: '#eee', padding: 10 }}>
    {JSON.stringify(state, null, 2)}
  </pre>
);
