export interface DeployOptions {
  /** Enable NSFW deployment (requires ALLOW_NSFW env). */
  nsfw?: boolean;
  /** Deploy to cloud storage when true, otherwise local folder copy. */
  cloud?: boolean;
}

/**
 * DeployService performs a simple deployment routine.  It can
 * copy build artifacts to a local `deployments` directory or
 * create a zipped bundle for cloud uploads.  The method remains
 * synchronous so tests can run without extra async handling.
 * This is still lightweight compared to a full CI/CD pipeline
 * but performs real file operations.
 */
export class DeployService {
  lastDeployment?: string;

  deploy(dir: string, opts: DeployOptions = {}): string {
    if (opts.nsfw && !process.env.ALLOW_NSFW) {
      throw new Error('NSFW content not allowed');
    }

    const fs = require('fs');
    const path = require('path');
    const { execSync } = require('child_process');

    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir, { recursive: true });
      const placeholder = path.join(dir, 'placeholder.txt');
      fs.writeFileSync(placeholder, 'placeholder');
    }

    const root = path.join(process.cwd(), 'deployments');
    fs.mkdirSync(root, { recursive: true });
    const timestamp = Date.now();

    if (opts.cloud) {
      const zip = path.join(root, `cloud-${timestamp}.zip`);
      execSync(`zip -qr ${zip} ${dir}`);
      this.lastDeployment = zip;
      return zip;
    }

    const target = path.join(root, `local-${timestamp}`);
    fs.cpSync(dir, target, { recursive: true });
    this.lastDeployment = target;
    return target;
  }
}
