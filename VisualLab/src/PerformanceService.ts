export interface DeviceSpecs {
  gpuScore: number;
  memory: number;
}

export interface PerformanceRenderOptions {
  resolution: number;
  bitrate: number;
}

export class PerformanceService {
  adjustSettings(deviceInfo: DeviceSpecs): PerformanceRenderOptions {
    const resolution = deviceInfo.gpuScore > 5 ? 1080 : 720;
    const bitrate = deviceInfo.memory > 4 ? 8000 : 4000;
    return { resolution, bitrate };
  }
}
