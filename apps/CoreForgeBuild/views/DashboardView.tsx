import React from 'react';
import { DragDropEditor } from '../components/DragDropEditor';
import { TemplateService } from '../services/TemplateService';

export const DashboardView: React.FC = () => {
  const service = new TemplateService();
  const templates = service.list();
  return (
    <div>
      <h2>Templates</h2>
      <ul>{templates.map(t => <li key={t.id}>{t.name}</li>)}</ul>
      <DragDropEditor />
    </div>
  );
};
