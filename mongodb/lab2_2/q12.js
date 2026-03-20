db.restaurants.find(
    {
        "localidade": {
            $in: ["Brooklyn", "Queens", "Staten Island"]
        },
    },
    {
        "nome": 1,
        "localidade": 1,
        "gastronomia": 1,
        "restaurant_id": 1, 
        "_id": 0
    }
)