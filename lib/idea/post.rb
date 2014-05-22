class IDEA::Post

  attr_reader :id, :title, :description, :category, :created_at, :user

  def initialize(data)
    @id = data[:id]
    @title = data[:title]
    @user = data[:user]
    @description = data[:description]
    @category = data[:category]
    @created_at = data[:created_at]
  end
end
