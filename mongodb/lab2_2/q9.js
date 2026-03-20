db.restaurants.find(
    {   
        "gastronomia": {$ne: "American"},
        "grades.score": {$gt: 70 },
        "address.coord.0": {$lt: -65} 
    },
    { "nome" :1, "_id": 0}
)