// Find the most popular guest artists (features) across all songs, based on average views. Only include features that appear in at least 3 songs, and provide a sample of notable tracks for each feature.

db.songs.aggregate([
  {
    $match: {
      features: { $exists: true, $ne: [] }
    }
  },
  {
    $unwind: "$features"
  },
  {
    $group: {
      _id: "$features",
      average_views: { $avg: "$views" },
      total_appearances: { $sum: 1 },
      notable_tracks: { $push: "$title" }
    }
  },
  {
    $match: {
      total_appearances: { $gte: 3 }
    }
  },
  {
    $sort: { average_views: -1 }
  },
  {
    $project: {
      _id: 0,
      guest_artist: "$_id",
      average_views: { $round: ["$average_views", 0] },
      total_appearances: 1,
      sample_tracks: { $slice: ["$notable_tracks", 3] }
    }
  },
  {
    $limit: 10
  }
])