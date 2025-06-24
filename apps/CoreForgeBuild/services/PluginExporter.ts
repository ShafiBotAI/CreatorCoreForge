import fs from 'fs';
import path from 'path';
import archiver from 'archiver';

/**
 * Utility to package a plugin directory into a distributable zip file.
 */
export async function exportPluginDir(dir: string, outDir: string): Promise<string> {
  const name = path.basename(dir);
  await fs.promises.mkdir(outDir, { recursive: true });
  const outFile = path.join(outDir, `${name}.zip`);
  const output = fs.createWriteStream(outFile);
  const archive = archiver('zip', { zlib: { level: 9 } });

  const done = new Promise<string>((resolve, reject) => {
    output.on('close', () => resolve(outFile));
    archive.on('error', (err: Error) => reject(err));
  });

  archive.pipe(output);
  archive.directory(dir, false);
  await archive.finalize();
  return done;
}
