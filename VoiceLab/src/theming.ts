import { useState, useEffect } from 'react';

type Theme = 'light' | 'dark' | string;

export function useTheme() {
  const [theme, setTheme] = useState<Theme>('light');

  useEffect(() => {
    document.documentElement.dataset.theme = theme;
  }, [theme]);

  return { theme, setTheme };
}
