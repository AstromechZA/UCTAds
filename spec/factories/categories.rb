FactoryGirl.define do

  sequence :cat_names do |n|
    "Category Number #{n}"
  end

  factory :category do
    name {FactoryGirl.generate(:cat_names)}
    fields({
      'some field' => {:type => 'string', :optional => false},
      'another' => {:type => 'select', :select => ['ONE','TWO','THREE']}
    })

    trait :with_sub_categories do
      after :create do |this|
        c1 = FactoryGirl.create(:category, fields: {'sub field' => {:type => 'string', :optional => true}})
        c2 = FactoryGirl.create(:category, fields: {})
        c1.children << FactoryGirl.create(:category, fields: {'sub sub field' => {:type => 'string', :optional => true}})

        this.children << c1
        this.children << c2
      end
    end
  end
end