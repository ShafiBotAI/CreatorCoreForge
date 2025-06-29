export default {
  preset: 'ts-jest/presets/default-esm',
  testEnvironment: 'node',
  extensionsToTreatAsEsm: ['.ts'],
  moduleNameMapper: {},
  collectCoverage: true,
  coverageThreshold: { global: { lines: 90 } },
};
