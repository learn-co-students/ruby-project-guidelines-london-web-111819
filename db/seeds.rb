15.times do 
    Customer.create(
        username: Faker::Internet.username,
        balance: Faker::Number.within(range: 0..200),
        age: Faker::Number.within(range: 14..30)
    )
end

    Store.create(
        name: "Cool Store"
        # menu: Store.menu
    )
    Store.create(
        name: "Normal Store"
        # menu: Store.menu
    )

10.times do
    Product.create(
        name: Faker::Cannabis.strain + " " + Faker::Cannabis.buzzword.capitalize,
        price: Faker::Number.within(range: 10..15),
        category: "Cannabis",
        store_id: 1
    )
end

10.times do
    Product.create(
        name: Faker::DcComics.villain + " " + Faker::Beer.brand,
        price: Faker::Number.within(range: 15..100),
        category: "Drinks",
        store_id: 1
    )
end

5.times do 
    Product.create(
        name: Faker::Hacker.noun.capitalize + " " + Faker::Hacker.verb.capitalize,
        price: Faker::Number.within(range: 50..100),
        category: "Hacking Tutorials",
        store_id: 1
    )
end

50.times do
    Order.create(
        status: ["pending", "completed"].sample,
        cost: Faker::Number.within(range: 10..150),
        customer_id: Faker::Number.within(range: 1..15),
        # store_id: [1,2].sample,
        product_id: Faker::Number.within(range: 1..25)
    )
end