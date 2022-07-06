# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)




sellers = User.where(workgroupe:"Продавец")
sellers_ids = sellers.map(&:id)
categories_ids = Category.all.map(&:id)
description_of_material = %w[товар услуга инструмент материал запчасть]
units = %w[шт тонна кв.м м кг ц л]
places = ["Московская область", "Ленинградская область", "Крым"]
phone = "+7 921 " + rand.to_s.last(3) + ' ' + rand.to_s.last(2) + ' ' + rand.to_s.last(2)
# places = "Московская область"


200.times do 
    Material.create(
        category_id:categories_ids.sample,
        description:description_of_material.sample,
        unit:units.sample,
        price_retail:(1..10).to_a.sample * 100,
        price_wholesale:(1..5).to_a.sample * 100,
        amount_wholesale:(1..5).to_a.sample * 10,
        phone:phone,
        place:places.sample,
        active:true,
        to_moderating:false,
        user_id:sellers_ids.sample
    )
end

