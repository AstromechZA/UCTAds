FactoryGirl.define do

  factory :category do
    name 'Some Category'
    fields({
      'some field' => {:type => 'string', :optional => false},
      'another' => {:type => 'select', :select => ['ONE','TWO','THREE']}
    })
    parent_id nil

    trait :with_sub_categories do
      after :create do |this|
        c1 = FactoryGirl.create(:category, fields: {'sub field' => {:type => 'string', :optional => true}})
        c2 = FactoryGirl.create(:category, fields: {})
        c1.children.push(FactoryGirl.create(:category, fields: {'sub sub field' => {:type => 'string', :optional => true}}))

        this.children.push(c1)
        this.children.push(c2)
      end
    end
  end
end