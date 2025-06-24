import { useState } from 'react';

export function useBreakpoint() {
  const [points, setPoints] = useState<number[]>([]);

  const add = (line: number) => {
    if (!points.includes(line)) setPoints([...points, line]);
  };

  const remove = (line: number) => {
    setPoints(points.filter((l) => l !== line));
  };

  const has = (line: number) => points.includes(line);

  return { points, add, remove, has };
}
