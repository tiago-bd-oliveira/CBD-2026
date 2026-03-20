db.restaurants.find(
    { "grades.score": {$gte: 80, $lte: 100} },
    { "nome" :1, "_id": 0}
)