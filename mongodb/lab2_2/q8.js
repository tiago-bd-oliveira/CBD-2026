db.restaurants.find(
    { "address.coord.0": {$lt: -95.7} },
    { "nome" :1, "_id": 0}
)