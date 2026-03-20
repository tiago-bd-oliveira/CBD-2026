// Average views by decade.

db.songs.aggregate([
  {
    $addFields: {
      decade: {
        $concat: [
          { $toString: { $multiply: [{ $floor: { $divide: ["$year", 10] } }, 10] } },
          "s"
        ]
      }
    }
  },
  {
    $group: {
      _id: "$decade",
      avg_views: { $avg: "$views" },
      total_songs: { $sum: 1 }
    }
  },
  {
    $project: {
      _id: 0,
      decade: "$_id",
      total_songs: 1,
      avg_views: { $round: ["$avg_views", 2] }
    }
  },
  { $sort: { decade: 1 } }
])
