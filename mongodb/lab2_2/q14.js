db.restaurants.find(
    { 
        "grades": { 
            $elemMatch: { 
                "grade": "A", 
                "score": 10, 
                "date": ISODate("2014-08-11T00:00:00Z") 
            } 
        } 
    },
    {
        "nome": 1,
        "grades": 1,
        "_id": 0
    }
)