db.restaurants.find(
    {"grades.score": {"$gt": 85}}
)