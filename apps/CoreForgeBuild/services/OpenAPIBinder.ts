/**
 * OpenAPIBinder creates basic client code from a limited OpenAPI
 * JSON spec. Only GET endpoints with string responses are handled.
 */
export class OpenAPIBinder {
  bind(spec: any): string[] {
    const endpoints: string[] = [];
    for (const [path, methods] of Object.entries(spec.paths || {})) {
      if (methods && (methods as any).get) {
        endpoints.push(`fetch('${path}').then(r => r.text())`);
      }
    }
    return endpoints;
  }
}
