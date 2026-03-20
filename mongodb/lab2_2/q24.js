db.restaurants.aggregate([
    {
        $match: {
            "address.rua": "Fifth Avenue"
        }
    },
    {
        $group: {
            _id: "$gastronomia",
        }
    },
    {
        $group: {
            _id: null,
            count: { $sum: 1 }
        }
    }
])

// db.restaurants.distinct(
//     "gastronomia",                       // 1. O campo do qual queremos valores únicos
//     { "address.rua": "Fifth Avenue" }    // 2. O filtro (equivalente ao $match)
// ).length