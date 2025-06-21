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

    spots.forEach(([x, y]) => {
      addIntensity(x, y, 30);
      for (let dx = -1; dx <= 1; dx++) {
        for (let dy = -1; dy <= 1; dy++) {
          if (dx === 0 && dy === 0) continue;
          addIntensity(x + dx, y + dy, 20 - (Math.abs(dx) + Math.abs(dy)) * 5);
        }
      }
    });

    return result;
  }
}
