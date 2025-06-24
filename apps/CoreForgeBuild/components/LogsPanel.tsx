import React, { useEffect, useState } from 'react';

export const LogsPanel: React.FC = () => {
  const [logs, setLogs] = useState<string[]>([]);

  useEffect(() => {
    const listener = (e: MessageEvent) => {
      if (typeof e.data === 'string') {
        setLogs((prev) => [...prev.slice(-99), e.data]);
      }
    };
    window.addEventListener('message', listener);
    return () => window.removeEventListener('message', listener);
  }, []);

  return (
    <pre style={{ maxHeight: 200, overflow: 'auto', background: '#111', color: '#0f0', padding: 10 }}>
      {logs.join('\n')}
    </pre>
  );
};
