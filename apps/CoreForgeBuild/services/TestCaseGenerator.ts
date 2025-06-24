export class TestCaseGenerator {
  generate(functionName: string): string[] {
    return [
      `${functionName} returns expected output`,
      `${functionName} handles edge cases`
    ];
  }
}
