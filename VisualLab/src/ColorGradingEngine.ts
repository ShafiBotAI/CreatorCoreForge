export class ColorGradingEngine {
  apply(frame: number[][], preset: string): number[][] {
    return frame.map(row => row.map(v => v));
  }
}
