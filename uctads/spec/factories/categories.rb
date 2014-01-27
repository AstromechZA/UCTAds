FactoryGirl.define do
  factory :category do
    name 'Some Category'
    fields 'field|field two|field three| another field'
    parent_id nil

    trait :with_sub_categories do
      after :create do |this|
        c1 = FactoryGirl.create(:category, fields: 'sub field one')
        c2 = FactoryGirl.create(:category, fields: 'sub field two|sub field three')
        c1.children.push(FactoryGirl.create(:category, fields: 'sub field four'))

        this.children.push(c1)
        this.children.push(c2)
      end
    end
  end
end