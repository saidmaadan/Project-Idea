require 'spec_helper.rb'

describe "post" do

id = 1
title = "My big idea"
description = "Put a function inside a function, inside a function"
category = "Web App"
created_at = Time.now

post = IDEA::Post.new(:id=>id, :title=>title, :description=>description, :category=>category, :created_at=>created_at)

  it "is created with an id" do
    expect(post.id).to eq(1)
  end

  it "is created with a title" do
    expect(post.title).to eq("My big idea")
  end

  it "is crreated with a description" do
    expect(post.description).to eq("Put a function inside a function, inside a function")
  end

  it "is created with a category" do
    expect(post.category).to eq("Web App")
  end

  it "is created with a timestamp" do
    time = Time.now.hour
    expect(post.created_at.hour).to eq(time)
  end
end
