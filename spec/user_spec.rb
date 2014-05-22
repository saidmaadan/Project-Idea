require 'spec_helper.rb'

describe "user" do

id = 1
user1 = "Said"
password1 = "12345"
new_user = IDEA::User.new(:id=>id, :username=>user1, :password=>password1)

  it "is created with an id" do
    expect(new_user.id).to eq(1)
  end

  it "is created with a username" do
    expect(new_user.username).to eq("Said")
  end

  it "is created with a password" do
    expect(new_user.password).to eq("12345")
  end
end
