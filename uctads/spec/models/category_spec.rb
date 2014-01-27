require 'spec_helper'

describe Category do

  it "has a valid factory" do
    FactoryGirl.create(:category).should be_valid
  end

  it "is valid with blank fields" do
    FactoryGirl.build(:category, fields: '').should be_valid
  end

  it "is invalid without a name" do
    FactoryGirl.build(:category, name: nil).should_not be_valid
  end

  it "is invalid with bad field def" do
    FactoryGirl.build(:category, fields: 'Thing|').should_not be_valid
    FactoryGirl.build(:category, fields: 'Thing|12').should_not be_valid
    FactoryGirl.build(:category, fields: 'Thing|bad!').should_not be_valid
    FactoryGirl.build(:category, fields: 'Thing||empty').should_not be_valid
  end

  it "can form a tree" do
    t = FactoryGirl.create(:category, :with_sub_categories)
    t.children.length.should == 2
    t.children[0].parent.id.should == t.id
  end

  it "can build set of fields" do
    c = FactoryGirl.create(:category)
    c.calculate_field_names().should == ['field', 'field two', 'field three', 'another field']
  end

  it "can build blank set of fields" do
    c = FactoryGirl.create(:category, fields: nil)
    c.calculate_field_names().should == []
  end

  it "correctly merges parent fields" do
    t = FactoryGirl.create(:category, :with_sub_categories)
    t.children[0].calculate_field_names.should == ['field', 'field two', 'field three', 'another field', 'sub field one']
  end




end
