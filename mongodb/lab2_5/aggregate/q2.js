// Upgraded query to find all posse cuts, now including verse counts

db.songs.aggregate([
  {
    $match: {
      "tag": "rap",
      "features.3": { $exists: true } 
    }
  },
  {
    $addFields: {
      verse_count: {
        $size: {
          $filter: {
            input: "$lyrics",
            as: "lyric",
            cond: { 
              $regexMatch: { 
                input: "$$lyric.type", 
                regex: /verse/i  
              }
             }
          }
        }
      }
    }
  },
  {
    $match: {
      verse_count: { $gte: 4 }
    }
  },
  {
    $project: {
      title: 1,
      artist: 1,
      features: 1,
      verse_count: 1
    }
  }
])