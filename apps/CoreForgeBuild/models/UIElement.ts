export interface UIElement {
  type: string;
  props?: Record<string, any>;
  children?: UIElement[];
}
