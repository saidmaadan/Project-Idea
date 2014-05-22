require 'spec_helper.rb'

describe "category" do

id = 1
title = "My big idea"
description = "Put a function inside a function, inside a function"
category = "Web App"
created_at = Time.now

category = IDEA::Post.new(:id=>id, :title=>title, :description=>description, :category=>category, :created_at=>created_at)

  it "stores data as a hash" do
    expect(category).to be_a kind_of(Hash)
  end
end
