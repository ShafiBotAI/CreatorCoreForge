export interface FacePosition { x: number; y: number; }

export class FaceTrackerService {
  track(frame: any): FacePosition[] {
    const w = frame?.width ?? 0;
    const h = frame?.height ?? 0;
    if (w === 0 || h === 0) return [];
    // Very naive face detection returning a single face at the center
    return [{ x: Math.round(w / 2), y: Math.round(h / 2) }];
  }
}
