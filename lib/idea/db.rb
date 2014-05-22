class IDEA::DB

  attr_accessor :users, :posts, :categories, :user_count, :post_count, :category_count

  def initialize
    @users = {}
    @posts = {}
    @categories = {}
    @user_count = 0
    @post_count = 0
    @category_count = 0
  end

  def create_user(data)
    data[:id ||= @user_count +1
    return nil if @users[data[:id]]
    @user_count += 1
    @users[data[:id]] = data
    build_user(data)
  end

  def get_user(id)
    data = @users[id]
    if !data.nil?
      build_user(data)
    end
  end

  def update_user(id, data)
    @users[id].merge!(data)
    build_user(@users[id])
  end

  def destroy_user(id)
    @users.delete(id)
  end

  def list_users
    list = []
    @users.each do |id, data|
      list << build_user(data)
    end
    list
  end

  def create_post(data)
    @post_count += 1
    data[:id] = @post_count
    data = @post[data[:id]]
    build_post(data)
  end

  def


  def build_user(data)
    IDEA::User.new(data)
  end

  def build_post(data)
    IDEA::Post.new(data)
  end

  def build_category(data)
    IDEA::Category.new(data)
  end
end

module IDEA
  def self.db
    @__db_instance ||= DB.new
  end
end



