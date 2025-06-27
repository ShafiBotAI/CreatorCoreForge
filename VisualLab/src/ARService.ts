export interface Scene {
  id: string;
}

export interface Overlay {
  modelId: string;
  position: [number, number, number];
}

export class ARService {
  private models = new Map<string, Buffer>();

  async registerModel(id: string, data: Buffer): Promise<void> {
    this.models.set(id, data);
  }

  async previewScene(scene: Scene): Promise<Overlay[]> {
    const overlays: Overlay[] = [];
    for (const id of this.models.keys()) {
      overlays.push({
        modelId: id,
        position: [Math.random(), Math.random(), Math.random()],
      });
    }
    console.log('Previewing scene', scene.id, 'with', overlays.length, 'models');
    return overlays;
  }
}
