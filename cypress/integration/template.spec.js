describe('template e2e', () => {
  it('visits the landing page', () => {
    cy.visit('/');
    cy.contains('CreatorCoreForge');
  });
});
