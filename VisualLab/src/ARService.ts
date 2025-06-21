export interface Scene {
  id: string;
}

export class ARService {
  async previewScene(scene: Scene): Promise<void> {
    console.log('Previewing scene', scene.id);
  }
}
