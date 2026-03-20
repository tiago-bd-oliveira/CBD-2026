db.restaurants.aggregate(
    {
        $group:{
            _id: null,
            numGrades: {$sum: {$size: "$grades"}}
        }
    }
)