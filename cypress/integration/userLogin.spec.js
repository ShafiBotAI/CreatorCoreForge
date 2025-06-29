describe('user login flow', () => {
  it('loads the login page', () => {
    cy.visit('http://localhost:3000/login');
    cy.contains('Login');
  });
});
