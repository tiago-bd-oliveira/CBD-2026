// Top 5 longest rap verses

db.songs.aggregate([
  {
    $match: {
      "tag": "rap"
    }
  },
  {
    $unwind: "$lyrics"
  },
  {
    $match: {
      "lyrics.type": { $regex: /verse/i }
    }
  },
  {
    $sort: { "lyrics.line_count": -1 }
  },
  {
    $limit: 5
  },
  {
    $project: {
      _id: 0,
      title: 1,
      artist: 1,
      line_count: "$lyrics.line_count",
      section_type: "$lyrics.type"
    }
  }
])