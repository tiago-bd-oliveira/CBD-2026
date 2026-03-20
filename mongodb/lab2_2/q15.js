db.restaurants.find(
    { 
        "grades.1.grade": "A", 
        "grades.1.date": ISODate("2014-08-11T00:00:00Z") 
    },
    {
        "restaurant_id": 1,
        "nome": 1,
        "grades.score": 1,
        "_id": 0
    }
)