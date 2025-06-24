import { jest } from '@jest/globals';

jest.mock('./src/ttsService', () => ({
  renderSegment: jest.fn(async () => new Blob(['audio']))
}));

jest.mock('./src/vaultService', () => ({
  saveToVault: jest.fn(async () => {}),
  loadFromVault: jest.fn(async () => null)
}));
