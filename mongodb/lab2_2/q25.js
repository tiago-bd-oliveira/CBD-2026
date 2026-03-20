db.restaurants.aggregate([
    {
        $unwind: "$grades"
    },
    {
        $match: {
            "grades.date": { $gte: ISODate("2014-01-01") }
        }
    },
    {
        $group: {
            _id: "$_id",
            nome: {$first: "$nome"},
            numGrades: { $sum: 1 },
            avgScore: { $avg: "$grades.score" }
        }
    },
    {
        $match: {
            avgScore: { $gt: 30 }
        }
    },
    {
        $project:{
            _id: 0,
            nome: 1,
            numGrades: 1,
            avgScore: 1
        }
    }
])

