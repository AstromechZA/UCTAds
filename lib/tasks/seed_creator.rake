namespace :seed_creator do

  desc "Print out the existing categories in a way which can be put in db/seeds.rb"
  task categories: :environment do

    Category.all.each do |cat|
      p = (cat.parent_id.nil? ? "nil" : "cat_#{cat.parent_id}")
      puts "cat_#{cat.id} = Category.create(name: #{cat.name.inspect}, fields: #{cat.fields.inspect}, parent: #{p})"
    end

  end


  desc "Print out the existing ads in a way that can be put in db/seeds.rb"
  task adverts: :environment do

    params = [:title, :description, :fieldvalues, :price, :price_type]

    Advert.all.each do |ad|

        # build params
        params_hash = {}
        params.each {|p| params_hash[p] = ad[p]}

        # turn into string and add category
        params_string = params_hash.inspect.to_s
        params_string = params_string[0..-2] + ", :category => cat_#{ad.category.id}" + '}'

        puts "Advert.create(#{params_string})"
    end

  end
end
