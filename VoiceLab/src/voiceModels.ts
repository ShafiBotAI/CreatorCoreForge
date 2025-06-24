export type VoiceModel = {
  id: string;
  speakerId: string;
  style?: string;
};

export class LocalVoiceAI {
  private models: Map<string, VoiceModel> = new Map();

  async trainVoiceModel(sampleAudio: Blob, speakerId: string): Promise<VoiceModel> {
    const id = `model-${Math.random().toString(36).slice(2)}`;
    const model: VoiceModel = { id, speakerId };
    this.models.set(id, model);
    // mock training delay
    await new Promise(r => setTimeout(r, 10));
    return model;
  }

  async transferVoiceStyle(sourceModel: VoiceModel, stylePreset: string): Promise<VoiceModel> {
    const id = `model-${Math.random().toString(36).slice(2)}`;
    const model: VoiceModel = { id, speakerId: sourceModel.speakerId, style: stylePreset };
    this.models.set(id, model);
    await new Promise(r => setTimeout(r, 10));
    return model;
  }

  async exportVoiceModel(modelId: string, format: "onnx" | "pt" | "tflite"): Promise<Blob> {
    const data = new Blob([`model:${modelId}:format:${format}`], { type: "application/octet-stream" });
    await new Promise(r => setTimeout(r, 10));
    return data;
  }
}
