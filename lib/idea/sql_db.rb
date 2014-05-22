require 'sqlite3'
require 'pry-debugger'
class IDEA::SQLDB
  attr_reader :db

  def initialize
    @db = SQLite3::DB.new

    @db.execute <<-SQL
    CREATE TABLE IF NOT EXISTS users(
      id INTEGER,
      username string,
      password string,
      PRIMARY KEY( id )
      );
    SQL

    @db.execute <<-SQL
    CREATE TABLE IF NOT EXISTS posts(
      id INTEGER,
      title string,
      description string,
      category string,
      created_at date,
      PRIMARY KEY( id )
      );
    SQL

    @db.execute <<-SQL
    CREATE TABLE IF NOT EXISTS categories(
      id INTEGER,
      category string,
      PRIMARY KEY( id )
      );
    SQL

  end

  def build_user(data)
    IDEA::User.new(data)
  end

  def build_post(data)
    IDEA::Post.new(data)
  end

  def create_user(data)
    @db.execute <<-SQL
    INSERT INTO user(username, password)
    VALUES("#{data[:username]}, #{data[:password]}")
    SQL

    result = @db.execute <<-SQL
    SELECT * FROM user where id = last_insert_rowid();
    SQL
    build_user(result.first)

  end

  def create_post(data)
    @db.execute <<-SQL
    INSERT INTO post(title, description)
    VALUES("#{data[:title]}, #{data[:description]}");
    SQL

    result = @db.execute <<-SQL
    SELECT * FROM post where id = last_insert_rowid();
    SQL
    build_post(result.all)
  end


end
