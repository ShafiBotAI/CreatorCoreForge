/**
 * @jest-environment jsdom
 */
import React from 'react';
import { render, screen } from '@testing-library/react';
import '@testing-library/jest-dom';
import { VoiceLabUI } from '../src/VoiceLabUI';

test('renders file input', () => {
  render(<VoiceLabUI />);
  const input = screen.getByTestId('file-input');
  expect(input).toBeInTheDocument();
});
