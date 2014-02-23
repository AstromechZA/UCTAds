FactoryGirl.define do

  factory :advert do
    title "The title of an advert"
    description "Some long piece of descriptive text. It just seems to go on and on."
    fieldvalues({
        'some field' => 'a string value',
        'another' => 'TWO'
    })
    category { FactoryGirl.create(:category) }
  end
end
