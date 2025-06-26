export interface ClipboardField {
  name: string;
  label: string;
  type: 'text' | 'number' | 'email';
  required?: boolean;
}

/**
 * parseClipboard converts newline separated field definitions into
 * a list of fields for the form builder. Supported syntax:
 *   Label
 *   Name: type
 *   Email: email, required
 */
export function parseClipboard(text: string): ClipboardField[] {
  return text
    .split(/\r?\n/)
    .map(l => l.trim())
    .filter(Boolean)
    .map(line => {
      const [left, right] = line.split(':');
      const label = left.trim();
      const options = right ? right.split(',').map(p => p.trim()) : [];
      const type = (options[0] as ClipboardField['type']) || 'text';
      const required = options.includes('required');
      const name = label.toLowerCase().replace(/\s+/g, '_');
      return { name, label, type, required } as ClipboardField;
    });
}
