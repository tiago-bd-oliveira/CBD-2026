db.restaurants.find(
    {
        "localidade": "Bronx",
        "gastronomia": { $in: ["American", "Chinese"] }
    },
    {
        "nome": 1,
        "localidade": 1,
        "gastronomia": 1,
        "_id": 0
    }
)