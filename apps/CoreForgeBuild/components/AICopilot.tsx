import React, { useState } from 'react';

export interface AICopilotProps {
  onAsk?: (question: string) => Promise<string>;
}

export const AICopilot: React.FC<AICopilotProps> = ({ onAsk }) => {
  const [text, setText] = useState('');
  const [reply, setReply] = useState('');
  const ask = async () => {
    const r = (await onAsk?.(text)) || 'No response';
    setReply(r);
  };
  return (
    <div>
      <input value={text} onChange={e => setText(e.target.value)} />
      <button onClick={ask}>Ask</button>
      <pre>{reply}</pre>
    </div>
  );
};
