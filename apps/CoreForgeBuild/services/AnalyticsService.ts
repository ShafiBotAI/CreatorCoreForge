export class AnalyticsService {
  private submits = 0;
  private abandons = 0;
  private fieldAdds = 0;

  recordFieldAdd() {
    this.fieldAdds++;
  }

  recordSubmit(success: boolean) {
    this.submits++;
    if (!success) this.abandons++;
  }

  stats() {
    return {
      abandonRate: this.submits ? this.abandons / this.submits : 0,
      fieldAdds: this.fieldAdds,
      submits: this.submits
    };
  }
}

export const analyticsService = new AnalyticsService();
