export class ColorGradingEngine {
  private presets: Record<string, (v: number) => number> = {
    warm: v => Math.min(255, v * 1.1),
    cool: v => Math.max(0, v * 0.9),
    highContrast: v => (v > 128 ? 255 : 0)
  };

  /**
   * Apply a simple color grading preset to the frame matrix.
   * Values are clamped between 0-255 for deterministic tests.
   */
  apply(frame: number[][], preset: string): number[][] {
    const fn = this.presets[preset] ?? ((v: number) => v);
    return frame.map(row => row.map(v => {
      const out = fn(v);
      return Math.min(255, Math.max(0, Math.round(out)));
    }));
  }
}
