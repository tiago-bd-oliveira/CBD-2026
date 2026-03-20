// Find all songs with 50000 views from the artist Young Thug.

db.songs.find(
  {
    views: { $gt: 50000 },
    $or: [
      { artist: "Young Thug" },
      { features: "Young Thug" }
    ]
  },
  { title: 1, artist: 1, views: 1, _id: 0 }
)