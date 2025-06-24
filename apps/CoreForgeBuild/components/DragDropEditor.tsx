import React from 'react';

export interface DragDropEditorProps {
  onFiles?: (files: FileList) => void;
}

export const DragDropEditor: React.FC<DragDropEditorProps> = ({ onFiles }) => {
  const handle = (e: React.DragEvent<HTMLDivElement>) => {
    e.preventDefault();
    if (e.dataTransfer.files && e.dataTransfer.files.length > 0) {
      onFiles?.(e.dataTransfer.files);
    }
  };
  return (
    <div
      data-testid="drop-zone"
      onDrop={handle}
      onDragOver={(e) => e.preventDefault()}
      style={{ border: '1px dashed gray', padding: 20 }}
    >
      Drop files here
    </div>
  );
};
