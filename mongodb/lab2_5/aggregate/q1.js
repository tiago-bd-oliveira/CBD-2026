// Top 10 artists by average views (minimum 2 songs).

db.songs.aggregate([
  {
    $group: {
      _id: "$artist",
      song_count: { $sum: 1 },
      avg_views: { $avg: "$views" }
    }
  },
  {
    $match: {
      song_count: { $gte: 2 }
    }
  },
  {
    $project: {
      _id: 0,
      artist: "$_id",
      song_count: 1,
      avg_views: { $round: ["$avg_views", 2] }
    }
  },
  { $sort: { avg_views: -1 } },
  { $limit: 10 }
])
