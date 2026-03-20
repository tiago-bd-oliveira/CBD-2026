db.restaurants.aggregate([
    {
        $group: {
            _id: "$localidade",
            count: { $sum: 1 }
        }
    }
])