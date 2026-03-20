// Average chorus line count by genre tag.

db.songs.aggregate([
  { $unwind: "$lyrics" },
  {
    $match: {
      "lyrics.type": "Chorus"
    }
  },
  {
    $group: {
      _id: "$tag",
      avg_chorus_lines: { $avg: "$lyrics.line_count" },
      chorus_sections: { $sum: 1 }
    }
  },
  {
    $project: {
      _id: 0,
      tag: "$_id",
      chorus_sections: 1,
      avg_chorus_lines: { $round: ["$avg_chorus_lines", 2] }
    }
  },
  { $sort: { avg_chorus_lines: -1 } }
])
