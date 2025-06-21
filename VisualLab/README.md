# VisualLab

VisualLab contains experimental TypeScript tools for advanced video rendering and scene editing.

## Getting Started

```bash
npm install
npm test
```

## Advanced Usage

After building the project you can run the sample renderer which outputs a short demo animation:

```bash
npm run build
node dist/demo.js
```

This will generate `demo.mp4` in the `dist` directory with default settings. Customize the `src/demo.ts` file to experiment with different scenes and transitions.
- **UnifiedAudioEngine** provides global volume control shared across apps.
