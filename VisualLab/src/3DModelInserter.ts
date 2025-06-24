export class ModelInserter {
  insert(scene: string, modelPath: string): string {
    return `${scene}+model(${modelPath})`;
  }
}
