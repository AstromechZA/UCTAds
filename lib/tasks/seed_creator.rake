namespace :seed_creator do

  desc "Print out the existing categories in a way which can be put in db/seeds.rb"
  task categories: :environment do

    Category.all.each do |cat|
      p = (cat.parent_id.nil? ? "nil" : "cat_#{cat.parent_id}")
      puts "cat_#{cat.id} = Category.create(name: #{cat.name.inspect}, fields: #{cat.fields.inspect}, parent: #{p})"
    end

  end

end
