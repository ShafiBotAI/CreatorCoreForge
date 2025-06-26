export interface AudioDevice {
  id: string;
  name: string;
}

export class AudioDeviceManager {
  private devices: AudioDevice[] = [];

  register(device: AudioDevice): void {
    this.devices.push(device);
  }

  list(): AudioDevice[] {
    return [...this.devices];
  }
}
