import React from 'react';

export const LivePreviewComponent: React.FC<{ src: string }> = ({ src }) => (
  <video src={src} controls autoPlay style={{ width: '100%' }} />
);
