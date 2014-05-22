require 'spec_helper.rb'

describe "db" do
  it "exists" do
    expect(DB).to be_a(Class)
  end

  it "returns a db" do
    expect(IDEA.db).to be_a(DB)
  end

  it "is a singleton" do
    db1 = IDEA.db
    db2 = IDEA.db
    expect(db1).to be(db2)
  end
end

describe "create_user in db" do
  user1 = IDEA::db.create_user({:username => "Said"})
  user2 = IDEA::db.create_user({:username => "Greg"})
  user3 = IDEA::db.create_user({:username => "Bob"})
  user4 = IDEA::db.create_user({:username => "Jim"})

  it "creates a new user with a name" do
    expect(user1.username).to eq("Said")
  end

  it "creates a new user with a unique ID" do
    expect(user1.id).to eq(1)
    expect(user2.id).to eq(2)
    expect(user3.id).to eq(3)
    expect(user4.id).to eq(4)
  end

  it "stores users in a hash" do
    expect(IDEA::db.users).to be_a(Hash)
  end

  it "retrieves username by id" do
    expect(IDEA::db.get_user(1).username).to eq("Said")
    expect(IDEA::db.get_user(1).id).to eq(1)
    expect(IDEA::db.get_user(1).password).to eq(nil)
  end
# binding.pry
  it "updates a user's username" do
    IDEA::db.update_user(2, :username=>"Gregory")
    expect(IDEA::db.users[2][:username]).to eq("Gregory")
  end


  it "deletes a user" do
    IDEA::db.destroy_user(2)
    IDEA::db.destroy_user(3)
    IDEA::db.destroy_user(4)
    expect(IDEA.db.users).to eq({1=>{:username=>"Said", :id=>1}})
  end

end



