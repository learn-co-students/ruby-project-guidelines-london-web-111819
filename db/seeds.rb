15.times do 
    Customer.create(
        username: Faker::Internet.username,
        balance: Faker::Number.within(range: 0..200),
        age: Faker::Number.within(range: 14..30)
    )
end

    Store.create(
        name: "Cool Store",
        # menu: Store.menu
    )
    Store.create(
        name: "Normal Store",
        # menu: Store.menu
    )

10.times do
    Product.create(
        name: Faker::Cannabis.strain + " " + Faker::Cannabis.buzzword.capitalize,
        price: Faker::Number.within(range: 10..15),
        prep_time: Faker::Number.within(range: 30..60),
        category: "Cannabis",
        store_id: 1
    )
end

10.times do
    Product.create(
        name: Faker::DcComics.villain + " " + Faker::Beer.brand,
        price: Faker::Number.within(range: 15..100),
        prep_time: Faker::Number.within(range: 60..300),
        category: "Drinks",
        store_id: 1
    )
end



