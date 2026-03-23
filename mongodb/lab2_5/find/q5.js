// Find all non-english underground (< 100000 views) rap songs from the 2010s.

db.songs.find(
  {
    year: { $gte: 2010, $lt: 2020 },
    tag: "rap",
    views: { $lt: 100000 },
    language: { $ne: "en" }
  },
  { title: 1, artist: 1, year: 1, views: 1, language: 1, _id: 0 }
).limit(10)
