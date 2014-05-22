class IDEA::Post

  attr_reader :id, :title, :description, :category, :created_at

  def initialize(data)
    @id = data[:id]
    @title = data[:title]
    @description = data[:description]
    @category = data[:category]
    @created_at = data[:created_at]

  end
end
