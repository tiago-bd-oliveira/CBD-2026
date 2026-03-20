db.restaurants.aggregate([
    { 
        $unwind: "$grades" 
    },
    {
        $group: {
            _id: { $dayOfWeek: "$grades.date" },
            numGrades: { $sum: 1 }
        }
    },
    {
        $sort: { "_id": 1 }
    }
])