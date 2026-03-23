// Find all pop songs from the 90s

db.songs.find(
  {
    year: { $gte: 1990, $lte: 1999 },
    tag: "pop",
  },
  { title: 1, artist: 1, tag: 1, year: 1, views: 1, _id: 0 }
).limit(10)