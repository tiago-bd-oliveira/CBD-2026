db.restaurants.find(
    { 
        "address.coord.1": {$gt: 42, $lt: 52},
    },
    {
        "restaurant_id": 1,
        "nome": 1,
        "address": 1,
        "_id": 0
    }
)