// Find all underground rap songs from the 2020s. (less than a 1000 views)

db.songs.find(
  {
    year: { $gte: 2020 },
    tag: "rap",
    views: { $lt: 1000}
  },
  { title: 1, artist: 1, year: 1, views: 1, _id: 0 }
)
