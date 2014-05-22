require 'spec_helper.rb'

describe "category" do

category = IDEA::Category.new(:id=>1, :category=>"Web App")

  it "is created with an id" do
    expect(category.id).to eq(1)
  end

  it "is created with a category description" do
    expect(category.category).to eq("Web App")
  end
end
