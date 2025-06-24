import React from 'react';

export interface ProductionButtonProps {
  label: string;
  onClick?: () => void;
}

/**
 * ProductionButton is a minimal styled button used across
 * the production UI. It ensures consistent appearance and
 * accessibility in dark/light themes.
 */
export const ProductionButton: React.FC<ProductionButtonProps> = ({ label, onClick }) => (
  <button
    style={{
      padding: '8px 16px',
      borderRadius: 4,
      border: '1px solid #444',
      backgroundColor: '#222',
      color: '#fff',
      cursor: 'pointer'
    }}
    onClick={onClick}
  >
    {label}
  </button>
);
