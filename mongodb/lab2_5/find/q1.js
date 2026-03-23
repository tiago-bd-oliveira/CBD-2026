// Find all songs that have a chorus bigger than 8 lines.

db.songs.find(
  { 
    lyrics: { 
      $elemMatch: { 
        type: "Chorus", 
        line_count: { $gt: 8 } 
      } 
    } 
  },
  { title: 1, artist: 1, _id: 0 }
).limit(10)