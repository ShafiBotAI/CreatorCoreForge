export interface Room {
  id: string;
  bookId: string;
  participants: string[];
}

export class GroupListenService {
  async createRoom(bookId: string): Promise<Room> {
    const room: Room = {
      id: Math.random().toString(36).slice(2),
      bookId,
      participants: []
    };
    return room;
  }
}
