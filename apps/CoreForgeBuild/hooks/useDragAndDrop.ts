import { useState, useCallback } from 'react';

export function useDragAndDrop() {
  const [files, setFiles] = useState<FileList | null>(null);
  const onDrop = useCallback((list: FileList) => setFiles(list), []);
  return { files, onDrop };
}
