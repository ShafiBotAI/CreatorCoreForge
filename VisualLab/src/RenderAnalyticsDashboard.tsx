import React from 'react';

export interface Metric { name: string; value: number; }

export const RenderAnalyticsDashboard: React.FC<{ metrics: Metric[] }> = ({ metrics }) => (
  <ul>
    {metrics.map(m => (
      <li key={m.name}>{m.name}: {m.value}</li>
    ))}
  </ul>
);
