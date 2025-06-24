export class ChromaKeyService {
  /**
   * Replace green screen pixels (0x00ff00) with provided background data.
   * This simplified algorithm keeps frame structure intact while making
   * visual transformations easy to test.
   */
  async replaceBackground(frames: number[][][], bgScene: number[][][]): Promise<number[][][]> {
    return frames.map((frame, fi) => {
      const bg = bgScene[fi % bgScene.length] || [];
      return frame.map((row, y) =>
        row.map((pixel, x) => (pixel === 0x00ff00 ? bg[y]?.[x] ?? pixel : pixel))
      );
    });
  }
}
