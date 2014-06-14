# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

cat_a = Category.create(name: "Automotive", fields: {})
cat_aa = Category.create(name: "Cars", fields: {"Make"=>{"optional"=>false}, "Model"=>{"optional"=>false}, "Year"=>{"optional"=>true}}, parent: cat_a)
cat_ab = Category.create(name: "Motorcycles & Scooters", fields: {"Make"=>{"optional"=>false}, "Model"=>{"optional"=>false}, "Year"=>{"optional"=>false}}, parent: cat_a)
cat_ac = Category.create(name: "Parts & Accessories", fields: {}, parent: cat_a)
cat_b = Category.create(name: "Electronics", fields: {})
cat_ba = Category.create(name: "Cellphones", fields: {}, parent: cat_b)
cat_bb = Category.create(name: "Computers", fields: {}, parent: cat_b)
cat_bba = Category.create(name: "Laptops", fields: {}, parent: cat_bb)
cat_bbb = Category.create(name: "PCs", fields: {}, parent: cat_bb)
cat_bbc = Category.create(name: "Components", fields: {}, parent: cat_bb)
cat_bbd = Category.create(name: "Accessories", fields: {}, parent: cat_bb)
cat_bc = Category.create(name: "Game Consoles", fields: {}, parent: cat_b)
cat_bd = Category.create(name: "Audio Equipment", fields: {}, parent: cat_b)
cat_be = Category.create(name: "Cameras", fields: {}, parent: cat_b)
cat_c = Category.create(name: "Fashion", fields: {})
cat_ca = Category.create(name: "Clothing", fields: {}, parent: cat_c)
cat_cb = Category.create(name: "Shoes", fields: {}, parent: cat_c)
cat_cc = Category.create(name: "Accessories", fields: {}, parent: cat_c)
