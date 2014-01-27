require 'spec_helper'

describe Advert do

  it "has a valid factory" do
    FactoryGirl.create(:advert).should be_valid
  end

  it "is invalid without a title" do
    FactoryGirl.build(:advert, title: '').should_not be_valid
    FactoryGirl.build(:advert, title: 'short').should_not be_valid
  end

end
