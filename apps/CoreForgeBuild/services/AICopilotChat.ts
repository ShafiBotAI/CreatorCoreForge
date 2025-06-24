export class AICopilotChat {
  ask(question: string): string {
    if (question.toLowerCase().includes('optimize')) {
      return 'Consider refactoring into smaller functions and using memoization.';
    }
    if (question.toLowerCase().includes('why')) {
      return 'The AI chose this approach for simplicity and readability.';
    }
    return 'No suggestion available.';
  }
}
