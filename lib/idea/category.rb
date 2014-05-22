class IDEA::Category

  attr_reader :id, :category

  def initialize(data)
    @id = data[:id]
    @category = data[:category]
  end
end
