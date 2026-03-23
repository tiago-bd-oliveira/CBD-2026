// Find all hits (songs with more than 1000000 views) from the artist JAY-Z.

db.songs.find(
  {
    views: { $gt: 1000000 },
    $or: [
      { artist: "JAY-Z" },
      { features: "JAY-Z" }
    ]
  },
  { title: 1, artist: 1, views: 1, _id: 0 }
).limit(10)