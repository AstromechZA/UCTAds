FactoryGirl.define do

  factory :advert_category, class: Category do
    name 'Some Category'
    fields({
      'some field' => {:optional => false},
      'another field' => {:optional => false, :select => ['ONE','TWO','THREE']}
    })
    parent_id nil
  end

  factory :advert do
    title "The title of an advert"
    description "Some long piece of descriptive text. It just seems to go on and on."
    category FactoryGirl.create(:advert_category)
    fieldvalues({
        'some field' => 'a string value',
        'another field' => 'TWO'
    })
  end
end
