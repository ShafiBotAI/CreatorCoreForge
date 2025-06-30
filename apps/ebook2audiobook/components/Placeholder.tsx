import React from 'react';

/**
 * Minimal status component used by tests. It displays a message
 * indicating that the eBook to audiobook conversion succeeded.
 */
export const ConversionStatus: React.FC<{ success: boolean }> = ({ success }) => {
  return (
    <div style={{ padding: '1rem', background: success ? '#dfd' : '#fdd' }}>
      {success ? 'Conversion complete' : 'Conversion failed'}
    </div>
  );
};

export default ConversionStatus;
