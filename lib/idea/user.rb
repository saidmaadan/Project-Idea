class IDEA::User

  attr_reader :id, :username, :password

  def initialize(data)
    @id = data[:id]
    @username = data[:username]
    @password = data[:password]
  end
end
