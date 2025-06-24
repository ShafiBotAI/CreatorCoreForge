const positions = new Map<string, number>();

export class DeviceSyncManager {
  async syncPosition(userId: string): Promise<void> {
    const position = positions.get(userId) || 0;
    positions.set(userId, position);
  }
}
