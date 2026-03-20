db.restaurants.aggregate([
    {
        $project: {
            "nome": 1,
            "numGrades": { $size: "$grades" },
            "_id": 0
        }
    },
    {
        $sort: { "numGrades": -1 }
    },
    {
        $limit: 3
    }
])