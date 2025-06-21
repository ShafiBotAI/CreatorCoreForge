export class BatchJobService {
  async runStyleTransfer(projectId: string, preset: string): Promise<void> {
    console.log(`Running style transfer for ${projectId} with ${preset}`);
  }
}
