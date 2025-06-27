import { useState, useEffect } from 'react';

export interface Storyboard {
  id: string;
  frames: string[];
}

export function useStoryboardCache(key: string) {
  const [board, setBoard] = useState<Storyboard | null>(null);

  useEffect(() => {
    const stored = localStorage.getItem(key);
    if (stored) {
      try {
        setBoard(JSON.parse(stored));
      } catch {
        // ignore parsing errors
      }
    }
  }, [key]);

  const save = (sb: Storyboard) => {
    setBoard(sb);
    localStorage.setItem(key, JSON.stringify(sb));
  };

  const clear = () => {
    setBoard(null);
    localStorage.removeItem(key);
  };

  return { board, save, clear } as const;
}
