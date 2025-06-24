export type SceneType = 'erotic' | 'fantasy' | 'surreal' | 'normal';

export class SceneToggleService {
  private enabledTypes: Set<SceneType> = new Set(['normal']);

  enable(type: SceneType): void {
    this.enabledTypes.add(type);
  }

  disable(type: SceneType): void {
    this.enabledTypes.delete(type);
  }

  isEnabled(type: SceneType): boolean {
    return this.enabledTypes.has(type);
  }
}
