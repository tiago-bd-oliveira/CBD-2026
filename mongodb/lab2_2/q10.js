db.restaurants.find(
    { "nome": /^Wil/ },
    {
        "restaurant_id": 1,
        "nome": 1,
        "localidade": 1,
        "gastronomia": 1,
        "_id": 0
    }
)