db.restaurants.find(
    {}, 
    {   
        "nome": 1,
        "gastronomia": 1,
        "localidade": 1,
        "_id": 0
    }
).sort(
    { 
        "gastronomia": 1, 
        "localidade": -1  
    }
)