require 'spec_helper'

describe Advert do

  it "has a valid factory" do
    FactoryGirl.create(:advert).should be_valid
  end

  it "is invalid without a title" do
    FactoryGirl.build(:advert, title: '').should_not be_valid
    FactoryGirl.build(:advert, title: 'tiny').should_not be_valid
  end

  it "is valid with present nonoptional field" do
    c = FactoryGirl.create(:category, fields: {'Author'=>{:optional=>false}})
    FactoryGirl.build(:advert, category: c, fieldvalues: {'Author'=>'John Smith'}).should be_valid
  end

  it "is invalid with missing nonoptional field" do
    c = FactoryGirl.create(:category, fields: {'Author'=>{:optional=>false}})
    FactoryGirl.build(:advert, category: c, fieldvalues: {}).should_not be_valid
  end

  it "is invalid with blank nonoptional field" do
    c = FactoryGirl.create(:category, fields: {'Author'=>{:optional=>false}})
    FactoryGirl.build(:advert, category: c, fieldvalues: {'Author'=>''}).should_not be_valid
  end

  it "is valid with missing optional field" do
    c = FactoryGirl.create(:category, fields: {'Author'=>{:optional=>true}})
    FactoryGirl.build(:advert, category: c, fieldvalues: {}).should be_valid
  end

  it "is valid with select option" do
    c = FactoryGirl.create(:category, fields: {'Bedrooms'=>{:optional=>false, :select=>['One', 'Two', 'Three', 'More than three']}})
    FactoryGirl.build(:advert, category: c, fieldvalues: {'Bedrooms'=>'Three'}).should be_valid
  end

  it "is invalid with bad select option" do
    c = FactoryGirl.create(:category, fields: {'Bedrooms'=>{:optional=>false, :select=>['One', 'Two', 'Three', 'More than three']}})
    FactoryGirl.build(:advert, category: c, fieldvalues: {'Bedrooms'=>'Zero'}).should_not be_valid
  end

end
