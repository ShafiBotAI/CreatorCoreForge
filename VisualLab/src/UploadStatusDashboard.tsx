import React from 'react';

export const UploadStatusDashboard: React.FC<{ logs: string[] }> = ({ logs }) => (
  <ul>{logs.map((l, i) => <li key={i}>{l}</li>)}</ul>
);
