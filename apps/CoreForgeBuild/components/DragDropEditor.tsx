import React, { useState } from 'react';
import { UISuggestionService } from '../services/UISuggestionService';

export interface DragItem {
  type: string;
  content: string;
}

export interface DragDropEditorProps {
  onFiles?: (files: FileList) => void;
  onBlock?: (block: DragItem) => void;
}

export const DragDropEditor: React.FC<DragDropEditorProps> = ({ onFiles, onBlock }) => {
  const [suggestions, setSuggestions] = useState<string[]>([]);
  const suggester = new UISuggestionService();

  const handle = (e: React.DragEvent<HTMLDivElement>) => {
    e.preventDefault();
    if (e.dataTransfer.files && e.dataTransfer.files.length > 0) {
      onFiles?.(e.dataTransfer.files);
    }
    const json = e.dataTransfer.getData('application/json');
    if (json) {
      try {
        const block = JSON.parse(json) as DragItem;
        if (block && block.type) {
          onBlock?.(block);
          setSuggestions(suggester.suggestNext([{ type: block.type }] as any));
        }
      } catch {
        /* ignore invalid */
      }
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
      {suggestions.length > 0 && (
        <ul>
          {suggestions.map((s) => (
            <li key={s}>{s}</li>
          ))}
        </ul>
      )}
    </div>
  );
};
