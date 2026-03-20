// Most frequent featured artists across songs.

db.songs.aggregate([
  { $unwind: "$features" },
  {
    $group: {
      _id: "$features",
      appearances: { $sum: 1 }
    }
  },
  {
    $project: {
      _id: 0,
      featured_artist: "$_id",
      appearances: 1
    }
  },
  { $sort: { appearances: -1 } },
  { $limit: 15 }
])
