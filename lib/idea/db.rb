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

  def build_user(data)
    IDEA::User.new(data)
  end

  def build_post(data)
    IDEA::Post.new(data)
  end
end


