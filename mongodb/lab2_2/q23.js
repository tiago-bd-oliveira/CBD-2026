db.restaurants.aggregate([
    {
        $match: {
            "gastronomia": "Portuguese",
            "address.coord.0": {$lt: -60}
        }
    },

    {
        $addFields: {
            score_sum: { $sum: "$grades.score" }
        }
    },

    {
        $match: {
            score_sum: { $gt: 50 }
        }
    },
])