export interface PluginManifest {
  name: string;
  version: string;
  inputs: string[];
  outputs: string[];
  permissions: string[];
  premium?: boolean;
  price?: number;
  dependencies?: string[];
}
