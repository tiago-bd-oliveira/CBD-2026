db.restaurants.find(
    {},
    {
        "restaurant_id": 1, 
        "nome": 1, 
        "localidade": 1, 
        "address.zipcode": 1,
        "_id": 0
    }
)