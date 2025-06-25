export function censorLayer(frame: string, level: number): string {
  return level > 0 ? `${frame}-censored-${level}` : frame;
}

export interface CensorRegionOption {
  region: string;
  level: number;
}

/**
 * Apply censor blur to specific regions of a frame. The output frame name is
 * suffixed with region blur information so downstream renderers can pick up
 * the correct mask overlays.
 */
export function censorRegions(
  frame: string,
  options: CensorRegionOption[]
): string {
  if (options.length === 0) return frame;
  const suffix = options
    .map((o) => `${o.region}-blur${Math.round(o.level)}`)
    .join('_');
  return `${frame}-${suffix}`;
}
