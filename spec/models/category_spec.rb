require 'spec_helper'

describe Category do

  it "has a valid factory" do
    FactoryGirl.create(:category).should be_valid
  end

  it "is valid with blank fields" do
    FactoryGirl.build(:category, fields: {}).should be_valid
  end

  it "is invalid without a name" do
    FactoryGirl.build(:category, name: nil).should_not be_valid
  end

  it "can form a tree" do
    t = FactoryGirl.create(:category, :with_sub_categories)
    t.children.length.should == 2
    t.children[0].parent.id.should == t.id
  end

  it "can build set of fields" do
    c = FactoryGirl.create(:category)
    c.build_fields_hash.keys.should == ['some field', 'another']
  end

  it "correctly merges parent fields" do
    t = FactoryGirl.create(:category, :with_sub_categories)
    t.children[0].build_fields_hash.keys.should == ['some field', 'another', 'sub field']
  end

end
