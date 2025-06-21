export class LensFlareService {
  detectBrightSpots(frame: number[][], threshold = 250): [number, number][] {
    const spots: [number, number][] = [];
    frame.forEach((row, y) => row.forEach((v, x) => {
      if (v > threshold) spots.push([x, y]);
    }));
    return spots;
  }

  applyLensFlare(frame: number[][]): number[][] {
    return frame; // placeholder
  }
}
