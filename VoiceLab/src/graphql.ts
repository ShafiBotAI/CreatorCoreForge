import { buildSchema } from 'graphql';

export const schema = buildSchema(`
  type Book { id: ID!, title: String }
  type Chapter { title: String, text: String }
  type Segment { id: ID!, text: String }
  type Playback { position: Int }

  type Query {
    book(id: ID!): Book
  }

  type Mutation {
    updatePlayback(id: ID!, position: Int!): Playback
  }
`);

export const root = {
  book: ({ id }: { id: string }) => ({ id, title: `Book ${id}` }),
  updatePlayback: ({ position }: { id: string; position: number }) => ({ position })
};
