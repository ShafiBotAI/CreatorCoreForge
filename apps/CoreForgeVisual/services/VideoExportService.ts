import { writeFileSync, mkdtempSync, rmSync } from 'fs';
import { tmpdir } from 'os';
import { join } from 'path';
import { execSync } from 'child_process';

export async function exportVideo(frames: Buffer[], output: string, fps = 30): Promise<void> {
  const dir = mkdtempSync(join(tmpdir(), 'cfv-'));
  try {
    frames.forEach((buf, i) => {
      const file = join(dir, `frame${i}.png`);
      writeFileSync(file, buf);
    });
    execSync(`ffmpeg -y -framerate ${fps} -i ${dir}/frame%d.png -c:v libx264 -pix_fmt yuv420p ${output}`);
  } finally {
    rmSync(dir, { recursive: true, force: true });
  }
}
