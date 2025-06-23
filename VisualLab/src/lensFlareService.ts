export class LensFlareService {
  detectBrightSpots(frame: number[][], threshold = 250): [number, number][] {
    const spots: [number, number][] = [];
    frame.forEach((row, y) => row.forEach((v, x) => {
      if (v > threshold) spots.push([x, y]);
    }));
    return spots;
  }

  applyLensFlare(frame: number[][]): number[][] {
    const result = frame.map(row => row.slice());
    const spots = this.detectBrightSpots(frame);
    const addIntensity = (x: number, y: number, inc: number) => {
      if (y >= 0 && y < result.length && x >= 0 && x < result[y].length) {
        result[y][x] = Math.min(255, result[y][x] + inc);
      }
    };

    const offsets: [number, number, number][] = [
      [0, 0, 30],
      [0, -1, 15],
      [0, 1, 15],
      [-1, 0, 15],
      [1, 0, 15],
      [-1, -1, 10],
      [-1, 1, 10],
      [1, -1, 10],
      [1, 1, 10],
    ];

    spots.forEach(([x, y]) => {
      for (const [dx, dy, inc] of offsets) {
        addIntensity(x + dx, y + dy, inc);
      }
    });

    return result;
  }
}
