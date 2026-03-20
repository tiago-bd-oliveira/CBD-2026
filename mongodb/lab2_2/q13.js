db.restaurants.find(
    { 
        "grades.score": { $not: { $gt: 3 } } 
    },
    {
        "nome": 1,
        "localidade": 1,
        "grades.score": 1,
        "gastronomia": 1,
        "_id": 0
    }
)