// Find all posse cuts.
// A posse cut is typically a rap song that features 4 or more verses from different artists 

db.songs.find(
  { 
    // 3 features + main artist = 4 total 
    "tag": "rap",
    "features.2": { $exists: true } 
  },
  { title: 1, artist: 1, features: 1, _id: 0 }
).limit(10)