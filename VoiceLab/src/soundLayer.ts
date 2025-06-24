export interface FXTrack {
  audio: Blob;
  startMs: number;
  volume: number;
}

export async function mixAmbientFX(baseAudio: Blob, fxTracks: FXTrack[]): Promise<Blob> {
  const parts = [baseAudio, ...fxTracks.map(fx => fx.audio)];
  return new Blob(parts, { type: baseAudio.type });
}
