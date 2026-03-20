// Songs with the highest total lyric line count.

db.songs.aggregate([
  {
    $project: {
      _id: 0,
      title: 1,
      artist: 1,
      year: 1,
      total_lines: {
        $sum: "$lyrics.line_count"
      }
    }
  },
  { $sort: { total_lines: -1 } },
  { $limit: 10 }
])
