/**
 * APIGenerator outputs minimal REST or GraphQL handlers so
 * generated apps can fetch data during previews.
 */
export class APIGenerator {
  generate(mode: 'rest' | 'graphql'): string {
    if (mode === 'graphql') {
      return 'type Query { hello: String }\n';
    }
    return 'GET /api/hello -> hello world';
  }
}
