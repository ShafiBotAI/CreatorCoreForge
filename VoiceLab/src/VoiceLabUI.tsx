import React, { useState } from 'react';
import { VoiceAnalyticsService, VoiceMetrics } from './VoiceAnalyticsService';

export const VoiceLabUI: React.FC = () => {
  const [metrics, setMetrics] = useState<VoiceMetrics | null>(null);
  const service = new VoiceAnalyticsService();

  const handleAudioChange = async (e: React.ChangeEvent<HTMLInputElement>) => {
    if (!e.target.files?.[0]) return;
    const blob = e.target.files[0];
    const result = await service.analyze(blob);
    setMetrics(result);
  };

  return (
    <div>
      <input data-testid="file-input" type="file" accept="audio/*" onChange={handleAudioChange} />
      {metrics && (
        <ul>
          <li>Pitch: {metrics.pitch}</li>
          <li>Timbre: {metrics.timbre}</li>
          <li>Rate: {metrics.rate}</li>
          <li>Valence: {metrics.valence}</li>
        </ul>
      )}
    </div>
  );
};
