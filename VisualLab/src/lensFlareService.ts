export type Frame = number[][];

/**
 * Lens flare utility with optimized pixel scanning.
 */
export class LensFlareService {
  /**
   * Detect bright pixels above the given threshold.
   * Uses raw loops for performance rather than nested callbacks.
   */
  detectBrightSpots(frame: Frame, threshold = 250): [number, number][] {
    const spots: [number, number][] = [];
    for (let y = 0; y < frame.length; y++) {
      const row = frame[y];
      for (let x = 0; x < row.length; x++) {
        if (row[x] > threshold) spots.push([x, y]);
      }
    }
    return spots;
  }

  applyLensFlare(frame: Frame): Frame {
    const result = frame.map(row => row.slice());
    const spots = this.detectBrightSpots(frame);
    const addIntensity = (x: number, y: number, inc: number) => {
      if (y >= 0 && y < result.length && x >= 0 && x < result[y].length) {
        result[y][x] = Math.min(255, result[y][x] + inc);
      }
    };

    const offsets: [number, number, number][] = LensFlareService.OFFSETS;

    spots.forEach(([x, y]) => {
      for (const [dx, dy, inc] of offsets) {
        addIntensity(x + dx, y + dy, inc);
      }
    });

    return result;
  }

  /** Offsets for flare intensity, ordered from strongest to weakest. */
  private static readonly OFFSETS: [number, number, number][] = [
    [0, 0, 30],
    [0, -1, 15],
    [0, 1, 15],
    [-1, 0, 15],
    [1, 0, 15],
    [-1, -1, 10],
    [-1, 1, 10],
    [1, -1, 10],
    [1, 1, 10]
  ];
}
