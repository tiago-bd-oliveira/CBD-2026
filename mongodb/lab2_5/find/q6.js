// Find all rap songs in English with more than 1000 views that have a verse containing the word "devil" (case-insensitive).

db.songs.find(
  {
    language: "en",
    tag: "rap",
    views: { $gt: 1000 },
    lyrics: {
      $elemMatch: {
        type: "Verse",
        content: { $regex: /(\bdevil[\s\S]*?)/i }
      }
    }
  },
  {
    title: 1,
    artist: 1,
    language: 1,
    "lyrics.$": 1, 
    _id: 0
  }
)