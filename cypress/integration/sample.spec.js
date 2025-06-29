describe('basic navigation', () => {
  it('loads homepage', () => {
    cy.visit('/');
    cy.contains('CreatorCoreForge');
  });
});
