import React from 'react';

export interface LivePreviewPaneProps {
  url: string;
  device?: 'ios' | 'android' | 'web';
}

const frameStyle: Record<string, React.CSSProperties> = {
  ios: { width: 375, height: 667, border: '1px solid #333' },
  android: { width: 360, height: 640, border: '1px solid #333' },
  web: { width: '100%', height: 500, border: '1px solid #333' }
};

export const LivePreviewPane: React.FC<LivePreviewPaneProps> = ({ url, device = 'web' }) => (
  <iframe title="live-preview" src={url} style={frameStyle[device]} />
);
