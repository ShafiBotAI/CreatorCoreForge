export type AuthMethod = 'jwt' | 'oauth2' | 'magic-link' | 'social';

/** Return simple authentication scaffolding code snippets. */
export class AuthScaffolder {
  scaffold(method: AuthMethod): string {
    switch (method) {
      case 'jwt':
        return `// JWT auth\napp.post('/login', (req, res) => {/* ... */});`;
      case 'oauth2':
        return `// OAuth2 flow\napp.get('/auth', (req, res) => {/* ... */});`;
      case 'magic-link':
        return `// Magic link auth\nexports.link = functions.https.onRequest(...);`;
      case 'social':
        return `// Social login\napp.post('/facebook', (req, res) => {/* ... */});`;
      default:
        return '';
    }
  }
}
