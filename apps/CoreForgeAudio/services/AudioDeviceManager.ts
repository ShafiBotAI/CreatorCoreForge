export interface AudioDevice {
  id: string;
  name: string;
}

export class AudioDeviceManager {
  private devices: AudioDevice[] = [];
  private activeId: string | null = null;

  register(device: AudioDevice): void {
    this.devices.push(device);
  }

  unregister(deviceId: string): void {
    this.devices = this.devices.filter(d => d.id !== deviceId);
    if (this.activeId === deviceId) {
      this.activeId = null;
    }
  }

  setActive(deviceId: string): void {
    if (this.devices.find(d => d.id === deviceId)) {
      this.activeId = deviceId;
    }
  }

  getActive(): AudioDevice | undefined {
    return this.devices.find(d => d.id === this.activeId);
  }

  async refreshFromBrowser(): Promise<void> {
    // Only available in browser/Electron contexts
    const navigatorRef: any = (globalThis as any).navigator;
    if (navigatorRef && navigatorRef.mediaDevices?.enumerateDevices) {
      const media = await navigatorRef.mediaDevices.enumerateDevices();
      this.devices = media
        .filter((m: any) => m.kind === 'audiooutput')
        .map((d: any) => ({ id: d.deviceId, name: d.label || 'Output' }));
    }
  }

  list(): AudioDevice[] {
    return [...this.devices];
  }
}
