export default {
  preset: 'ts-jest/presets/default-esm',
  testEnvironment: 'node',
  extensionsToTreatAsEsm: ['.ts'],
  moduleNameMapper: {},
  setupFiles: ['<rootDir>/jest.setup.ts'],
  collectCoverage: true,
  coverageThreshold: { global: { lines: 70 } }
};
