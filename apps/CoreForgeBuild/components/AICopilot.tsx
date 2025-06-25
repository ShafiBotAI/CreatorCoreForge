import React, { useState } from 'react';

export interface AICopilotProps {
  onAsk?: (question: string) => Promise<string>;

}

export const AICopilot: React.FC<AICopilotProps> = ({ onAsk }) => {
=======
  hotkeys?: Record<string, string>;
}

export function registerHotkeys(
  target: { addEventListener(type: string, cb: (e: any) => void): void },
  hotkeys: Record<string, string>,
  ask: (q: string) => void
) {
  target.addEventListener('keydown', (e: any) => {
    const key = e.key?.toLowerCase();
    if (key && hotkeys[key]) {
      ask(hotkeys[key]);
    }
  });
}

export const AICopilot: React.FC<AICopilotProps> = ({ onAsk, hotkeys }) => {

  const [text, setText] = useState('');
  const [reply, setReply] = useState('');
  const ask = async () => {
    const r = (await onAsk?.(text)) || 'No response';
    setReply(r);
  };

=======
  React.useEffect(() => {
    if (hotkeys) {
      registerHotkeys(window, hotkeys, q => onAsk?.(q).then(r => setReply(r || 'No response')));
    }
  }, [hotkeys]);

  return (
    <div>
      <input value={text} onChange={e => setText(e.target.value)} />
      <button onClick={ask}>Ask</button>
      <pre>{reply}</pre>
    </div>
  );
};
