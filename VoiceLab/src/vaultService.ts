const prefix = 'vault:';

function encode(data: ArrayBuffer): string {
  return btoa(String.fromCharCode(...new Uint8Array(data)));
}

function decode(data: string): ArrayBuffer {
  const binary = atob(data);
  const arr = new Uint8Array(binary.length);
  for (let i = 0; i < binary.length; i++) arr[i] = binary.charCodeAt(i);
  return arr.buffer;
}

export async function saveToVault(bookId: string, audio: Blob) {
  const buf = await audio.arrayBuffer();
  localStorage.setItem(prefix + bookId, encode(buf));
}

export async function loadFromVault(bookId: string): Promise<Blob | null> {
  const data = localStorage.getItem(prefix + bookId);
  if (!data) return null;
  return new Blob([decode(data)]);
}
