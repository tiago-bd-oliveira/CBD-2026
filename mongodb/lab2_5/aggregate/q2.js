// Number of songs per genre tag.

db.songs.aggregate([
  {
    $group: {
      _id: "$tag",
      total_songs: { $sum: 1 }
    }
  },
  {
    $project: {
      _id: 0,
      tag: "$_id",
      total_songs: 1
    }
  },
  { $sort: { total_songs: -1 } }
])
