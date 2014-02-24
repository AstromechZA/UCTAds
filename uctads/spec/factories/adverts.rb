FactoryGirl.define do

  factory :advert do
    title "The title of an advert"
    description "Some long piece of descriptive text. It just seems to go on and on."
    fieldvalues({
        'some field' => 'a string value',
        'another' => 'TWO'
    })
    price_type 'exact'
    price 12.34
    category { FactoryGirl.create(:category) }
  end
end
