// Find all english rap songs from Lil Wayne with more than 100000 views that have a verse containing the word "swag" (case-insensitive).

db.songs.find(
  {
    language: "en",
    tag: "rap",
    artist: "Lil Wayne",
    views: { $gt: 100000 },
    lyrics: {
      $elemMatch: {
        type: "Verse",
        content: { $regex: /(\bswag[\s\S]*?)/i }
      }
    }
  },
  {
    title: 1,
    artist: 1,
    views: 1,
    language: 1,
    "lyrics.$": 1, 
    _id: 0
  }
).limit(10)