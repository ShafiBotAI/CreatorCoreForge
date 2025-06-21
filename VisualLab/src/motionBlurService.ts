export class MotionBlurService {
  apply(frame: number[][], intensity = 0.5): number[][] {
    return frame.map(row => row.map(value => value * (1 - intensity)));
  }
}
