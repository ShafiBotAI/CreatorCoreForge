import { execSync } from 'child_process';
import path from 'path';

export type Platform = 'ios' | 'android' | 'mac' | 'windows' | 'web';

export class BuildEngine {
  constructor(private projectRoot = process.cwd()) {}

  build(platform: Platform): string {
    const outDir = path.join(this.projectRoot, 'dist', platform);
    try {
      switch (platform) {
        case 'web':
          if (process.env.NODE_ENV !== 'test') {
            execSync('npm run build', { stdio: 'inherit' });
          }
          break;
        case 'ios':
        case 'android':
        case 'mac':
        case 'windows':
          execSync(`echo building ${platform}`, { stdio: 'inherit' });
          break;
      }
      return outDir;
    } catch (err) {
      throw new Error(`Build failed for ${platform}: ${err}`);
    }
  }
}
