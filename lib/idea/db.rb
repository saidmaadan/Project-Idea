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
    data[:id] ||= @user_count +1
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
    list_user = []
    @users.each do |id, data|
      list_user << build_user(data)
    end
    list_user
  end

  def create_post(data)
    @post_count += 1
    data[:id] = @post_count
    @posts[ @post_count ] = data
    build_post(data)
  end

  def get_post(id)
    data = @posts[id]
    build_post(data)
  end

  def update_post(id, data)
    @posts[id].merge!(data)
    build_post(@posts[id])
  end

  def destroy_post(id)
    @posts.delete(id)
  end

  def list_post
    list_post = []
    @posts.each do |id, data|
      list_post << build_post(data)
    end
    list_post
  end

  def create_category(data)
    @category_count += 1
    data[:id] = @category_count
    data = @categories[data[:id]]
    build_category(data)
  end

  def get_category(id)
    data = @categories[id]
    build_category(data)
  end

  def update_category(id, data)
    @categories[id].merge!(data)
    build_category(@categories[id])
  end

  def destroy_category(id)
    @categories.delete(id)
  end



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



