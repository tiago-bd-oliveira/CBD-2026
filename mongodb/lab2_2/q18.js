db.restaurants.find(
    {
        "localidade": "Brooklyn",
        "gastronomia": {$ne: "American"},
        "grades.grade": "A"
    }, 
    {   
        "nome": 1,
        "gastronomia": 1,
        "localidade": 1,
        "grades.grade": 1,
        "_id": 0
    }
).sort(
    { 
        "gastronomia": -1,  
    }
)