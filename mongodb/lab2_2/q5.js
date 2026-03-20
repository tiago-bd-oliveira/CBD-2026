db.restaurants.find(
    {"localidade": "Bronx"},
)
.limit(15)
.sort(
    {"nome": 1}
)