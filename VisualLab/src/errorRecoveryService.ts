export class ErrorRecoveryService {
  constructor(private retries = 1) {}

  async execute<T>(fn: () => Promise<T>): Promise<T> {
    let lastError: unknown;
    for (let i = 0; i <= this.retries; i++) {
      try {
        return await fn();
      } catch (e) {
        lastError = e;
      }
    }
    throw lastError;
  }
}
