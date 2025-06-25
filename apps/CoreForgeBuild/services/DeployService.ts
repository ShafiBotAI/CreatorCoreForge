export interface DeployOptions {
  nsfw?: boolean;
  cloud?: boolean;
}

/**
 * DeployService performs a very small check for NSFW gating
 * and returns the target location for deployment. This is a
 * simplified placeholder for a real CI/CD pipeline.
 */
export class DeployService {
  lastDeployment?: string;
  deploy(dir: string, opts: DeployOptions = {}): string {
    if (opts.nsfw && !process.env.ALLOW_NSFW) {
      throw new Error('NSFW content not allowed');
    }
    this.lastDeployment = opts.cloud ? `cloud:${dir}` : dir;
    return opts.cloud ? `https://cloud.example.com/${dir}` : dir;
  }
}
